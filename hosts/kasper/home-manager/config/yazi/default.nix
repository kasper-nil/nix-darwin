{ ... }:
{
  # Core yazi config only. Plugins/flavors under ~/.config/yazi/{plugins,flavors}
  # stay unmanaged (install via `ya pack`); existing ones are left in place.
  xdg.configFile = {
    "yazi/yazi.toml".source = ./yazi.toml;
    "yazi/keymap.toml".source = ./keymap.toml;
    "yazi/theme.toml".source = ./theme.toml;
    "yazi/init.lua".source = ./init.lua;
    "yazi/package.toml".source = ./package.toml;
  };
}
