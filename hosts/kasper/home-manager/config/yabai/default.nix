{ ... }:
{
  # yabai execs ~/.config/yabai/yabairc, so it must be executable.
  xdg.configFile."yabai/yabairc" = {
    source = ./yabairc;
    executable = true;
  };
}
