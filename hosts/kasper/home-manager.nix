{ inputs, ... }:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    # Use the system nixpkgs (incl. allowUnfree) instead of a separate HM one.
    useGlobalPkgs = true;
    useUserPackages = true;

    # First switch won't clobber existing dotfiles: a conflicting real file is
    # moved to `<name>.hm-bak` instead of aborting. Your ~/.dotfiles bare repo
    # stays the rollback source.
    backupFileExtension = "hm-bak";

    extraSpecialArgs = { inherit inputs; };

    users.kasper = {
      imports = [ ./home-manager ];
    };
  };
}
