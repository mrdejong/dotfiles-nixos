{ config, inputs, pkgs, vars, ... }:

{
  home = {
    packages = [
      pkgs.hello
    ];
  };

  xdg = {                                               # Add Nix Packages to XDG_DATA_DIRS
    enable = true;
    systemDirs.data = [ "/home/${vars.user}/.nix-profile/share" ];
  };

  nix = {                                               # Nix Package Manager Settings
    settings ={
      auto-optimise-store = true;
    };
    package = pkgs.nixFlakes;                           # Enable Flakes
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;                    # Allow Proprietary Software.
}
