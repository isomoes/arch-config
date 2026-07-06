# compose

Docker Compose stacks for the self-hosted servers in this config, organized one
directory per service — the container counterpart to [`systemd/user/`](../systemd/user).

Unlike `systemd/`, no tool auto-reads this folder; each stack is started
explicitly:

```sh
docker compose -f compose/<service>/compose.yaml up -d
```

## Services

| Service | Image | Port | Replaces |
| ------- | ----- | ---- | -------- |
| [`iread/`](iread/) | `ghcr.io/isomoes/iread:latest` | `127.0.0.1:9999` | `systemd/user/iread.service` |
| [`agentsview/`](agentsview/) | `ghcr.io/kenn-io/agentsview:latest` | `127.0.0.1:8585` | `systemd/user/agentsview.service` |
| [`kookeey-bridge/`](kookeey-bridge/) | `gogost/gost` | `127.0.0.1:10011` | — (new) |
| [`frpc/`](frpc/) | `snowdreamtech/frpc` | host netns (dials out to `frps`) | — (new) |

### iread

The image stores its SQLite db and OPML mirror in `/data`; the compose file
bind-mounts `~/.config/iread` there, so the container reuses the same
`iread.db` + `feeds.opml` the systemd service used. Cut over with:

```sh
systemctl --user disable --now iread.service
docker compose -f compose/iread/compose.yaml up -d   # http://localhost:9999
```

To test without disturbing the running service, point a throwaway container at a
copy of the data on a spare port:

```sh
cp -a ~/.config/iread /tmp/iread-testdata
docker run --rm -p 8788:8787 -v /tmp/iread-testdata:/data ghcr.io/isomoes/iread:latest
# open http://localhost:8788, then Ctrl-C
```

### agentsview

A read-only viewer: it bind-mounts your agent session dirs (`~/.claude/projects`,
`~/.codex/sessions`, `~/.local/share/opencode`) read-only and re-indexes them
into its own SQLite archive in the named `agentsview-data` volume — so there is
nothing to migrate, and your session files are never written to. Cut over:

```sh
systemctl --user disable --now agentsview.service
docker compose -f compose/agentsview/compose.yaml up -d   # http://127.0.0.1:8585
```

Gotcha baked into the compose file: agentsview only honors API requests whose
`Host` is in an allowlist derived from its **container** port (10011). Because the
host port differs (8585), every `/api/*` call 403s unless the server is started
with `--public-url http://127.0.0.1:8585` to register the real browser origin.
Add a source dir by mounting it read-only under `/agents/<name>` and setting the
matching `*_DIR` env (see the upstream `docker-compose.prod.yaml`).

### kookeey-bridge

A [gost](https://github.com/go-gost/gost) container that exposes a plain HTTP
proxy on `127.0.0.1:10011` and forwards every request through an authenticated
Kookeey **SOCKS5** gateway (`gate.kookeey.info`). Point any HTTP client at it to
egress through Kookeey:

```sh
export HTTPS_PROXY=http://127.0.0.1:10011 HTTP_PROXY=http://127.0.0.1:10011
curl https://api.ipify.org    # shows the Kookeey exit IP
```

The upstream URL contains your Kookeey username/password, so it is **not** in
`compose.yaml`. It lives in `kookeey-bridge/.env` (gitignored via
`compose/**/.env`) as `KOOKEEY_UPSTREAM`, which Compose auto-loads from the
compose file's own directory. Set it up once, then start the stack:

```sh
cd compose/kookeey-bridge && cp .env.example .env && $EDITOR .env   # fill in creds + gateway port
docker compose -f compose/kookeey-bridge/compose.yaml up -d         # http://127.0.0.1:10011
```

`KOOKEEY_UPSTREAM` format — `PORT` is the **gateway** port Kookeey assigned you
(distinct from the local proxy port, which is fixed at `10011`):

```
socks5://USERNAME:PASSWORD@gate.kookeey.info:PORT
```

If `.env` is missing or `KOOKEEY_UPSTREAM` is unset, `up` aborts immediately with
a message naming the file to create (the `:?` guard in `compose.yaml`) rather
than starting a broken proxy.

**Networking:** unlike the other stacks, this one uses `network_mode: host`
rather than a published `ports:` mapping. Docker's bridge network has no
outbound egress on this host — forwarded/NAT'd container traffic never leaves,
even though the host itself reaches the internet and `systemctl restart docker`
doesn't fix it — so gost runs in the host network namespace and reaches the
Kookeey gateway directly. Because host mode ignores `ports:`, the loopback-only
bind lives in `-L=http://127.0.0.1:10011`, keeping the proxy reachable only from
this host. If bridge egress is ever repaired, revert to `ports:` +
`-L=http://:10011` to match the other stacks.

### frpc

An [frp](https://github.com/fatedier/frp) **client** that reverse-tunnels this
host's SSH port out through a public `frps` server, so you can `ssh` back into
this NAT'd/firewalled machine from anywhere. frpc dials the `frps` server and
asks it to listen on `remotePort`; connections there are forwarded back down the
tunnel to `127.0.0.1:22` here. Set it up once, then start it:

```sh
cd compose/frpc && cp .env.example .env && $EDITOR .env   # frps addr, token, remote port
docker compose -f compose/frpc/compose.yaml up -d
# then from elsewhere:  ssh -p <FRP_SSH_REMOTE_PORT> <user>@<FRP_SERVER_ADDR>
```

Like `kookeey-bridge`, this stack uses `network_mode: host` — not for a
published port (frpc dials out, it never listens on the LAN) but because this
host's Docker bridge network has no outbound egress, so a bridged frpc could
never reach the `frps` server. Host mode also lets it reach the host's own sshd
directly at `127.0.0.1:22`.

Config split, same convention as the other stacks: the committed
[`frpc.toml`](frpc/frpc.toml) carries only the structure, referencing every
deployment value via frp's `{{ .Envs.* }}` env templating; the real values
(`frps` address, **auth token**, remote port) live in the gitignored
`compose/frpc/.env` (matched by `compose/**/.env`) and are injected into the
container by `compose.yaml`, where frpc renders them at startup. Required vars
are `:?`-guarded, so `up` aborts naming the missing one rather than starting a
misconfigured tunnel. TOML config needs frp ≥ v0.52, which the `:latest` image
satisfies.

**Security:** this publishes a route to your SSH port on the public `frps` host
(`<FRP_SERVER_ADDR>:<FRP_SSH_REMOTE_PORT>`). Use key-only auth and a strong,
unique `frps` token.
