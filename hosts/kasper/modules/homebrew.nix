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
      autoUpdate = true;
      upgrade = true;
    };

    # Third-party formula repos. All currently-tapped repos are kept so the zap
    # cleanup doesn't untap anything in use; koekeishiya/formulae added for
    # yabai + skhd. Prune any you don't actually need.
    taps = [
      "asmvik/formulae"
      "fastrepl/fastrepl"
      "felixkratz/formulae"
      "gechr/tap"
      "koekeishiya/formulae"
      "microsoft/foundrylocal"
      "oven-sh/bun"
      "sinelaw/fresh"
      "supabase/tap"
      "theboredteam/boring-notch"
      "typewhisper/tap"
    ];

    # CLI tools (your `brew leaves`) + yabai/skhd (from koekeishiya/formulae).
    brews = [
      "bat"
      "btop"
      "eza"
      "fastfetch"
      "fd"
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
      "micro"
      "mise"
      "neovim"
      "opencode"
      "pandoc"
      "pnpm"
      "poppler"
      "postgresql@15"
      "posting"
      "redis"
      "skhd"
      "spotify_player"
      "starship"
      "swift-format"
      "tmux"
      "xcodegen"
      "yabai"
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

    # MAS (Mac App Store) omitted entirely for now — friction at switch (App
    # Store sign-in, no auto-uninstall on removal). To use later: add the `mas`
    # brew above and a `masApps = { … };` block here.
  };
}
