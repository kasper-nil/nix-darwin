{ ... }:
{
  # NOTE: Karabiner-Elements rewrites this file from its own UI. As an HM
  # symlink it points into a read-only /nix/store, so GUI edits will fail. If
  # you tweak Karabiner via the app often, drop this and keep it in the bare
  # repo instead.
  xdg.configFile."karabiner/karabiner.json".source = ./karabiner.json;
}
