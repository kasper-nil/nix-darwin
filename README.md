# nix-darwin

kasper's macOS config — [nix-darwin] + [home-manager], with packages managed via [Homebrew].

## Layout

```
flake.nix                       # inputs + darwinConfigurations."kasper" + formatter
CLAUDE.md                       # operating manual for AI-assisted edits
.mcp.json                       # mcp-nixos server (option / package lookup)
.claude/                        # permissions, format-on-edit hook, /nix-option command
bin/nix-option                  # offline nix-darwin option search (pinned)
hosts/kasper/
├── configuration.nix           # host entrypoint — imports modules + home-manager
├── home-manager.nix            # wires home-manager into nix-darwin
├── modules/                    # system-level nix-darwin config
│   ├── homebrew.nix            # brews + casks + taps (single source of truth)
│   ├── networking.nix
│   ├── nix.nix
│   ├── nixpkgs.nix             # hostPlatform / system arch
│   ├── security.nix            # Touch ID for sudo (+ tmux reattach)
│   ├── system.nix              # macOS defaults
│   └── users.nix
└── home-manager/
    ├── home.nix
    └── config/                 # per-tool dotfiles, each its own module
        ├── bat/ btop/ git/ helix/ karabiner/ kitty/ skhd/
        ├── starship/ tmux/ wezterm/ yabai/ yazi/ zsh/
        └── default.nix         # imports all of the above
```

## Usage

Apply the config:

```sh
darwin-rebuild switch --flake .#kasper
```

Update inputs (nixpkgs, nix-darwin, home-manager) then rebuild:

```sh
nix flake update
darwin-rebuild switch --flake .#kasper
```

## Packages

Packages are installed through **Homebrew**, not nix — `homebrew.nix` writes a
Brewfile and runs `brew bundle` on every switch. `onActivation.cleanup = "zap"`
makes that file authoritative: any formula or cask **not** listed there is
uninstalled on rebuild. Add/remove packages by editing the lists, not the system.

Upgrades happen **only during a switch** (`upgrade = true`), never from a stray
`brew install` (`autoUpdate = false`). Run `brew update` yourself occasionally so
Homebrew's formula index doesn't drift.

> nix-darwin does **not** install Homebrew itself — install it first via the
> [official installer][Homebrew].

Tool *configs* (dotfiles) are managed by home-manager under `home-manager/config/`.

## AI-assisted management

This repo is set up to be edited by Claude Code (or any agent). **`CLAUDE.md`** is
the operating manual — it encodes the guardrails (git-add new files, never `sudo
nix flake update`, build before switch) and how-tos for adding packages, dotfiles,
and options. Two lookup paths stop the agent inventing options that don't exist:

- **`./bin/nix-option <regex>`** — greps nix-darwin options built from *this
  flake's exact pinned revision*. Offline; can't drift from your config.
- the **`nixos` MCP server** (mcp-nixos, in `.mcp.json`) — nixpkgs package search
  plus home-manager / nix-darwin options from the live index.

`nix fmt` uses `nixfmt-rfc-style`; a Claude Code hook runs it on every `.nix` edit.
Touch ID is enabled for `sudo` (`modules/security.nix`) so agent-run switches can
authenticate without a TTY.

## Window management

Tiling via [yabai] + [skhd] (hotkeys), plus `borders` for the active-window
highlight. yabai and skhd come from the `asmvik/formulae` tap — a fork with
macOS 26 support. Do not switch them to upstream `koekeishiya/formulae`: it
replaces the binaries and invalidates the scripting addition's sudoers entry.

[nix-darwin]: https://github.com/nix-darwin/nix-darwin
[home-manager]: https://github.com/nix-community/home-manager
[Homebrew]: https://brew.sh
[yabai]: https://github.com/koekeishiya/yabai
[skhd]: https://github.com/koekeishiya/skhd
