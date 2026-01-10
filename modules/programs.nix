{ config, pkgs, inputs, ... }:

{
  # ===============================
  # Programs
  # ===============================
  #programs.hyprland.enable = true;
  programs.firefox.enable = true;
  programs.virt-manager.enable = true;
  programs.wireshark.enable = true;
  programs.firejail.enable = true;

  # ===============================
  # DMS
  # ===============================
  programs.dms-shell = {
  enable = true;
  package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;

  quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;


  systemd = {
    enable = true;             # Systemd service for auto-start
    restartIfChanged = true;   # Auto-restart dms.service when dms-shell changes
  };
  
  # Core features
  enableSystemMonitoring = true;     # System monitoring widgets (dgop)
  enableClipboard = true;            # Clipboard history manager
  enableVPN = true;                  # VPN management widget
  enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
  enableAudioWavelength = true;      # Audio visualizer (cava)
  enableCalendarEvents = true;       # Calendar integration (khal)
  };

  # ===============================
  # Steam
  # ===============================
  programs.steam = {
    enable = true;

    extraEnv = {
      __NV_PRIME_RENDER_OFFLOAD = "1";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };

}
