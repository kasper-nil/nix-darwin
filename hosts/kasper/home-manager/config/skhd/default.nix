{ ... }:
{
  # skhd (asmvik fork, v0.3.9) does NOT search ~/.config/skhd/skhdrc — it only
  # checks $XDG_CONFIG_HOME/skhd/skhdrc (unset in its launchd env), then ~/.skhdrc.
  # So the keymap MUST live at ~/.skhdrc, or skhd starts with zero bindings and
  # every hotkey silently dies. (Verified: reload logs "could not open ~/.skhdrc".)
  home.file.".skhdrc".source = ./skhdrc;

  # Helper invoked by skhdrc via absolute path ($HOME/.config/skhd/close-or-quit.sh).
  xdg.configFile."skhd/close-or-quit.sh" = {
    source = ./close-or-quit.sh;
    executable = true;
  };
}
