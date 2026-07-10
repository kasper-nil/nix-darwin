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
      "mas"
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

    # The `mas` CLI is installed (above) but no `masApps = { … };` block is
    # declared yet — Mac App Store apps stay unmanaged for now, since declaring
    # them adds friction at switch (App Store sign-in, no auto-uninstall).
  };
}
