{
  description = "Flake configuration!";

  inputs = {
    nixpkgs.url  = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url  = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, nur, nixvim, ... }:
    let
      vars = {
        user = "alexander";
        terminal = "kitty";
        editor = "vim";
      };
    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager nur nixvim vars;
        }
      );

      homeConfigurations = (
        import ./home {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager vars;
        }
      );
    };
}
