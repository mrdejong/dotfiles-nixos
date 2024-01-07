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

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      flake = false;
    };

    doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.emacs-overlay.follows = "emacs-overlay";
    };
  };
  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, nur, nixvim, doom-emacs, ... }:
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
          inherit inputs nixpkgs nixpkgs-unstable home-manager nur nixvim doom-emacs vars;
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
