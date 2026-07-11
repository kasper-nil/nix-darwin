{ ... }:
{
  # Touch ID for `sudo`. nix-darwin already manages /etc/pam.d/sudo_local, so
  # this is a clean write — it adds `auth sufficient pam_tid.so` there.
  #
  # Why this matters for AI-assisted switches: when Claude Code runs
  # `sudo darwin-rebuild switch` from its Bash tool (no TTY), plain `sudo` pops
  # the Touch ID dialog and you approve with a fingerprint. (Do NOT pass
  # `sudo -n` — it skips PAM entirely and dies with "a password is required".)
  security.pam.services.sudo_local = {
    touchIdAuth = true;

    # Keep Touch ID working inside tmux/screen via pam_reattach.
    reattach = true;
  };
}
