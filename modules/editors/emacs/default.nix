{ config, pkgs, vars, ... }:
{
  services.emacs = {
    enable = true;
  };

  system.userActivationScripts = {
    doomEmacs.text = ''
      source ${config.system.build.setEnvironment}
      EMACS="/home/${vars.user}/.emacs.d"

      if [ ! -d "$EMACS" ]; then
        ${pkgs.git}/bin/git clone https://github.com/hlissner/doom-emacs.git $EMACS
        yes | $EMACS/bin/doom install
      else
        $EMACS/bin/doom sync
      fi
    '';
  };

  environment.systemPackages = with pkgs; [
    clang
    coreutils
    emacs
    fd
    git
    ripgrep
  ];
}
