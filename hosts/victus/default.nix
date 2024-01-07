{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ] ++
  ( import ../../modules/desktops/virtualisation );

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  laptop.enable = true;
  # Window manager
  gnome.enable = true;

  environment = {
    systemPackages = with pkgs; [
      simple-scan
      onlyoffice-bin
    ];
  };

  programs.light.enable = true;

  systemd.tmpfiles.rules = [                # Temporary Bluetooth Fix
    "d /var/lib/bluetooth 700 root root - -"
  ];
  systemd.targets."bluetooth".after = ["systemd-tmpfiles-setup.service"];
}
