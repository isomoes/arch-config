# Linux Desktop Config

Personal configuration files for Linux desktop setup. Shell (zsh) configuration is maintained in the parent repository: [linux-config](https://github.com/isomoes/linux-config)

## Applications

| Category    | Application | Configuration                                                          | Description                    |
| ----------- | ----------- | ---------------------------------------------------------------------- | ------------------------------ |
| Desktop     | Sway        | [`sway/`](sway/)                                                       | Wayland window manager         |
| Desktop     | Waybar      | [`waybar/`](waybar/)                                                   | System status bar              |
| Desktop     | Kitty       | [`kitty/`](kitty/)                                                     | Terminal emulator              |
| Development | Zsh         | [`.zshrc`](https://github.com/isomoes/linux-config/blob/master/.zshrc) | Shell (in parent repo)         |
| Development | Neovim      | [`nvim/`](https://github.com/isomoes/nvim-config)                      | Text editor (git submodule)    |
| Development | Git         | [`git/`](git/)                                                         | Version control settings       |
| Development | Lazygit     | -                                                                      | Terminal UI for git            |
| Media       | OBS Studio  | [`obs-studio/`](obs-studio/)                                           | Video recording                |
| Media       | mvideo      | [`mvideo`](https://github.com/isomoes-video/mvideo)                    | Script-based video editor      |
| Media       | MPV         | -                                                                      | Video player                   |
| Media       | fcitx5      | -                                                                      | Chinese input method           |
| Media       | Chrome      | -                                                                      | Web browser                    |
| Services    | iread       | [`compose/iread/`](compose/iread/)                                     | RSS reader (SQLite + OPML)     |
| Services    | agentsview  | [`compose/agentsview/`](compose/agentsview/)                           | Read-only agent session viewer |
| Keybindings | Surfingkeys | [`Surfingkeys-conf.js`](Surfingkeys-conf.js)                           | Browser vim keybindings        |
| Keybindings | Xremap      | [`xremap/`](xremap/)                                                   | System-wide key remapping      |

> Docker Compose service stacks (`Services`) — see [`compose/`](compose/) for setup and cutover notes.

## Notes

- Legacy configs (River, Hyprland, etc.) remain in repo but are no longer actively used

## References

- [linux-config](https://github.com/isomoes/linux-config) - Parent repository with zsh and system configs
- [gnuunixchad/dotfiles](https://github.com/gnuunixchad/dotfiles)
