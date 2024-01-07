{ config, pkgs, ...  }:
{
  home-manager.users.${vars.user} = {
    home = {
      packages = with pkgs; [
        teams-for-linux
      ];
    };
  };
}
