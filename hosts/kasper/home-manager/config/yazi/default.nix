{ ... }:
{
  # Core yazi config. Third-party plugins/flavors under ~/.config/yazi/{plugins,flavors}
  # stay unmanaged (install via `ya pack`); existing ones are left in place.
  # cd-quit is hand-written rather than fetched, so it is managed here.
  xdg.configFile = {
    "yazi/yazi.toml".source = ./yazi.toml;
    "yazi/keymap.toml".source = ./keymap.toml;
    "yazi/theme.toml".source = ./theme.toml;
    "yazi/init.lua".source = ./init.lua;
    "yazi/package.toml".source = ./package.toml;
    "yazi/glow-mocha.json".source = ./glow-mocha.json;

    # Enter on a directory cd's there and quits, so the `y` shell wrapper follows.
    "yazi/plugins/cd-quit.yazi/main.lua".source = ./plugins/cd-quit.yazi/main.lua;
  };
}
