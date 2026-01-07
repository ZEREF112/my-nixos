{ config, pkgs, ... }:

{
  # ===============================
  # Imports
  # ===============================
  imports = [
    ./hardware-configuration.nix
  ];

  # ===============================
  # Bootloader
  # ===============================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ===============================
  # Networking
  # ===============================
  networking.hostName = "DASH";
  networking.networkmanager.enable = true;

  # ===============================
  # Time & Locale
  # ===============================
  time.timeZone = "Asia/Damascus";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = [ "ar_SA.UTF-8" ];


  # ===============================
  # Console
  # ===============================
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # ===============================
  # XDG / Wayland Base
  # ===============================
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";

  # ===============================
  # Sound (PipeWire)
  # ===============================

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  security.rtkit.enable = true;

  # ===============================
  # Printing
  # ===============================
  #services.printing.enable = true;

  # ===============================
  # OpenSSH
  # ===============================
  #services.openssh.enable = true;

  # ===============================
  # Firewall
  # ===============================
  networking.firewall.enable = true;

  # ===============================
  # System Version
  # ===============================
  system.stateVersion = "24.11";
}
