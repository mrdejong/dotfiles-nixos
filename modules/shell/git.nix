{ pkgs, vars, ... }:
{
  home-manager.users.${vars.user} = {
    programs.git = {
      enable = true;
      userName = "Alexander de Jong";
      userEmail = "alexander@dutchcaffeine.nl";
      extraConfig = {
        init = { defaultBranch = "main"; };
      };
    };
  };
}
