{ config, pkgs, inputs, ... }:

{
  home.username = "fouad";
  home.homeDirectory = "/home/fouad";

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  ############################
  # Hyprland
  ############################
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
  };

  # External Hyprland config
  xdg.configFile."hypr" = {
    source = ./hypr;
    force = true;
  };

  ############################
  # DankMaterialShell
  ############################
  home.packages = [
    inputs.dms.packages.${pkgs.system}.default
    inputs.dms.packages.${pkgs.system}.quickshell
  ];

  home.sessionVariables = {
    DMS_ENABLE = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    NIXOS_OZONE_WL = "1";
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "1";
  };

  ############################
  # XDG Portal
  ############################
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };

  ############################
  # Quickshell service
  ############################
  systemd.user.services.quickshell = {
    Unit = {
      Description = "Quickshell (DMS)";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart =
        "${inputs.dms.packages.${pkgs.system}.quickshell}/bin/quickshell";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
