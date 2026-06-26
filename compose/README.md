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
| [`iread/`](iread/) | `ghcr.io/isomoes/iread:latest` | `9999` | `systemd/user/iread.service` |
| [`agentsview/`](agentsview/) | `ghcr.io/kenn-io/agentsview:latest` | `127.0.0.1:8585` | `systemd/user/agentsview.service` |

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
`Host` is in an allowlist derived from its **container** port (8080). Because the
host port differs (8585), every `/api/*` call 403s unless the server is started
with `--public-url http://127.0.0.1:8585` to register the real browser origin.
Add a source dir by mounting it read-only under `/agents/<name>` and setting the
matching `*_DIR` env (see the upstream `docker-compose.prod.yaml`).
