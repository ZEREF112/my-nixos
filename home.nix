
{ config, pkgs, ... }:

{
  home.username = "fouad";
  home.homeDirectory = "/home/fouad";

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # Run Hyprland With HM
  wayland.windowManager.hyprland.enable = true;

  # Hyprland Config
  xdg.configFile."hypr".source = ./hypr;
}
