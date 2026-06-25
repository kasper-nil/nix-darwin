{ ... }:
{
  xdg.configFile = {
    "skhd/skhdrc".source = ./skhdrc;
    "skhd/close-or-quit.sh" = {
      source = ./close-or-quit.sh;
      executable = true;
    };
  };
}
