{ lib, inputs, nixpkgs, nixpkgs-unstable, home-manager, nur, nixvim, emacs-overlay, vars, ...
}:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{
  victus = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs system unstable emacs-overlay vars;
      host = {
        hostName = "victus";
        mainMonitor = "DP-1";
        secondMonitor = "eDP-1";
      };
    };
    modules = [
      nur.nixosModules.nur
      nixvim.nixosModules.nixvim
      ./victus
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}
