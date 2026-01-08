
{ config, pkgs, ... }:

{
  home.username = "fouad";
  home.homeDirectory = "/home/fouad";

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
  };
  # Run Hyprland With HM
  wayland.windowManager.hyprland.enable = true;

  # Hyprland Config
  xdg.configFile."hypr".source = ./hypr;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };
}
