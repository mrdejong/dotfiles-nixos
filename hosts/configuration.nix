{ config, lib, pkgs, unstable, inputs, vars, ... }:

let
  terminal = pkgs.kitty;
in
{
  imports = ( import ../modules/desktops ++
              import ../modules/editors ++
              import ../modules/hardware ++
              import ../modules/programs ++
              import ../modules/shell ++
              import ../modules/theming );

  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" ];
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_MEASUREMENT = "nl_NL.UTF-8";
      LC_MONETARY = "nl_NL.UTF-8";
      LC_TIME = "nl_NL.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  fonts.packages = with pkgs; [
    carlito
    vegur
    source-code-pro
    jetbrains-mono
    font-awesome
    corefonts
    fira
    (nerdfonts.override {
      fonts = [
        "FiraCode"
      ];
    })
  ];

  environment = {
    variables = {
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [
      terminal
      btop
      coreutils
      git
      killall
      lshw
      nano
      nix-tree
      pciutils
      ranger
      smartmontools
      tldr
      usbutils
      wget
      xdg-utils

      # Vid/Aud
      alsa-utils
      feh
      mpv
      pavucontrol
      pipewire
      pulseaudio
      vlc

      appimage-run
      google-chrome
      remmina

      gnome.file-roller
      okular
      pcmanfm
      p7zip
      rsync
      unzip
      unrar
      zip
    ] ++
    (with unstable; [
      firefox
    ]);
  };

  programs = {
    dconf.enable = true;
  };

  hardware.pulseaudio.enable = false;
  services = {
    printing = {
      enable = true;
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    openssh = {
      enable = true;
      allowSFTP = true;
      extraConfig = ''
        HostKeyAlgorithms +ssh-rsa
      '';
    };
  };

  # flatpak.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11";

  home-manager.users.${vars.user} = {
    home.stateVersion = "23.11";
    programs = {
      home-manager.enable = true;
    };
  };
}
