{ ... }:
{
  # This machine runs the upstream (nixos.org) multi-user Nix installer, which
  # already owns the nix-daemon LaunchDaemon and /etc/nix/nix.conf. Leaving
  # nix-darwin's Nix management off keeps the two from fighting over the daemon
  # plist and nix.conf.
  #
  # Consequence: nix-darwin does NOT manage garbage collection or nix.conf here.
  # Collect garbage by hand — `sudo nix-collect-garbage -d`. (To hand nix.conf +
  # automatic GC to nix-darwin instead, set this `true`; it backs up the
  # installer's nix.conf first. That is the "correct" setup for an upstream
  # install, but it takes over the daemon, so only flip it deliberately.)
  nix.enable = false;
}
