{ ... }:
{
  # All packages live here (configs via home-manager, packages via Homebrew).
  # nix-darwin writes a Brewfile and runs `brew bundle`; it does NOT install
  # Homebrew itself — keep using your existing brew install.
  homebrew = {
    enable = true;

    onActivation = {
      # "zap": this file is the single source of truth. Any formula/cask NOT
      # listed below is uninstalled on `darwin-rebuild switch`. Prune the lists,
      # not the system.
      cleanup = "zap";

      # Upgrade outdated formulae/casks, but only during a switch — never let a
      # stray `brew install` auto-update the index behind your back. This is
      # nix-darwin's recommended pairing: upgrades happen at one deliberate
      # moment (activation) instead of at random. Trade-off: run `brew update`
      # yourself now and then so Homebrew's formula index isn't stale.
      #
      # WARNING: the day an upgrade bumps yabai/skhd, the scripting addition's
      # sudoers entry (keyed to the binary hash) goes stale silently — re-run
      # `sudo yabai --install-sa` afterwards. asmvik/formulae rarely moves, so
      # this is infrequent, but it is the one upgrade that can break tiling.
      upgrade = true;
      autoUpdate = false;
    };

    # Third-party formula repos. All currently-tapped repos are kept so the zap
    # cleanup doesn't untap anything in use. Prune any you don't actually need.
    taps = [
      "asmvik/formulae"
      "fastrepl/fastrepl"
      "felixkratz/formulae"
      "gechr/tap"
      "microsoft/foundrylocal"
      "nikitabobko/tap"
      "oven-sh/bun"
      "sinelaw/fresh"
      "supabase/tap"
      "theboredteam/boring-notch"
      "typewhisper/tap"
    ];

    # CLI tools (your `brew leaves`). Tap-qualified names are pinned deliberately:
    #   - yabai/skhd come from asmvik/formulae, a fork that supports macOS 26.
    #     Plain "yabai"/"skhd" would resolve to koekeishiya/formulae and replace
    #     them, breaking the scripting addition (its sudoers entry is keyed to
    #     the binary hash).
    #   - borders (JankyBorders) is invoked by yabai/yabairc.
    brews = [
      "asmvik/formulae/skhd"
      "asmvik/formulae/yabai"
      "bat"
      "btop"
      "eza"
      "fastfetch"
      "fd"
      "felixkratz/formulae/borders"
      "ffmpeg"
      "fnm"
      "fresh-editor"
      "fzf"
      "gh"
      "git-delta"
      "glow"
      "helix"
      "jq"
      "lazygit"
      "lua"
      "micro"
      "mise"
      "neovim"
      "opencode"
      "oven-sh/bun/bun"
      "pandoc"
      "pnpm"
      "poppler"
      "postgresql@15"
      "posting"
      "redis"
      "spotify_player"
      "starship"
      "supabase/tap/supabase"
      "swift-format"
      "tmux"
      "xcodegen"
      "yazi"
      "zoxide"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
    ];

    # GUI apps (your `brew list --cask`). Names verbatim — `claude-code@latest`
    # and `wezterm@nightly` are versioned cask names.
    casks = [
      "1password"
      "alt-tab"
      "boring-notch"
      "brave-browser"
      "claude"
      "claude-code@latest"
      "discord"
      "docker-desktop"
      "dotnet-sdk"
      "firefox"
      "font-jetbrains-mono-nerd-font"
      "font-meslo-lg-nerd-font"
      "gcloud-cli"
      "google-chrome"
      "karabiner-elements"
      "kitty"
      "libreoffice"
      "notion"
      "obsidian"
      "raycast"
      "redis-insight"
      "slack"
      "spotify"
      "steam"
      "visual-studio-code"
      "vlc"
      "wezterm@nightly"
      "whichspace"
    ];

    # MAS (Mac App Store) omitted entirely — unused. The `mas` CLI is therefore
    # absent from `brews` above, so the zap cleanup uninstalls it on switch.
    # To use later: add the `mas` brew back plus a `masApps = { … };` block here.
  };
}
