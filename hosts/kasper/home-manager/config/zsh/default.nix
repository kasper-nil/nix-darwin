{ ... }:
{
  # ~/.zshrc (literal file). Switch to programs.zsh later if you want HM to own
  # aliases/plugins/history declaratively.
  home.file.".zshrc".source = ./zshrc;

  # ~/.zshenv — sourced by ALL zsh invocations, incl. `zsh -c`. Required so skhd
  # (runs each keybinding via `/bin/zsh -c`) can find brew tools like yabai/jq;
  # skhd's own launchd PATH is a stale snapshot that misses them. See the file.
  home.file.".zshenv".source = ./zshenv;
}
