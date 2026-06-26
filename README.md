# nix-darwin

kasper's macOS config — [nix-darwin] + [home-manager], with packages managed via [Homebrew].

## Layout

```
flake.nix                       # inputs + darwinConfigurations."kasper"
hosts/kasper/
├── configuration.nix           # host entrypoint — imports modules + home-manager
├── home-manager.nix            # wires home-manager into nix-darwin
├── modules/                    # system-level nix-darwin config
│   ├── homebrew.nix            # brews + casks + taps (single source of truth)
│   ├── networking.nix
│   ├── nix.nix
│   ├── nixpkgs.nix             # hostPlatform / system arch
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

> nix-darwin does **not** install Homebrew itself — install it first via the
> [official installer][Homebrew].

Tool *configs* (dotfiles) are managed by home-manager under `home-manager/config/`.

## Window management

Tiling via [yabai] + [skhd] (hotkeys). Both come from the `koekeishiya/formulae` tap.

[nix-darwin]: https://github.com/nix-darwin/nix-darwin
[home-manager]: https://github.com/nix-community/home-manager
[Homebrew]: https://brew.sh
[yabai]: https://github.com/koekeishiya/yabai
[skhd]: https://github.com/koekeishiya/skhd
