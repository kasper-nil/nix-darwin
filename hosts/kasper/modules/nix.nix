{ ... }:
{
  # nix-darwin manages the nix daemon by default; Determinate already does that,
  # so disable it here to avoid two writers fighting over /etc/nix/nix.conf.
  nix.enable = false;
}
