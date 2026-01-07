
{ pkgs, ... }:

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
  quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;


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

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "1";
  };

  # ===============================
  # Packages
  # ===============================
  environment.systemPackages = with pkgs; [
    # Browsers
    brave

    # Internet
    qbittorrent
    telegram-desktop
    thunderbird
    jdownloader
    localsend

    # Virtualization & Gaming
    virt-viewer
    spice-gtk
    protonup-qt
    lutris
    wineWowPackages.stable
    winetricks

    # System tools
    fastfetch
    nvtop
    pciutils
    usbutils
    asusctl
    git
    wget
    vim
    emacs
    tcpdump
    gparted
    gnome-disk-utility
    cpu-x
    speedtest-cli

    # Productivity
    libreoffice
    obsidian
    vscodium
    netbeans
    neovim
    github-desktop
    pdfarranger
    gimp
    darktable
    remmina
    realvnc-vnc-viewer
  ];
}
