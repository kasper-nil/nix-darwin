{
  description = "kasper's macOS config — nix-darwin + home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      ...
    }@inputs:
    let
      # System is inferred from nixpkgs.hostPlatform (set in modules/nixpkgs.nix).
      mkDarwin =
        hostname:
        nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/${hostname}/configuration.nix ];
        };
    in
    {
      darwinConfigurations = {
        kasper = mkDarwin "kasper";
      };

      # `nix fmt`. Also what the Claude Code format-on-edit hook shells out to,
      # so agent-written Nix always lands RFC-style.
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
    };
}
