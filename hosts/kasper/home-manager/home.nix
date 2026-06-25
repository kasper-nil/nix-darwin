{ ... }:
{
  home = {
    username = "kasper";
    homeDirectory = "/Users/kasper";

    # Read the home-manager changelog before changing this.
    stateVersion = "24.05";

    # Intentionally empty — packages are declared via Homebrew in
    # modules/homebrew.nix. Add here only if you want a pkg from nixpkgs.
    packages = [ ];
  };
}
