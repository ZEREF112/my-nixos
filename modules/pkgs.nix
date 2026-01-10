
{ config, pkgs, inputs, ... }:

{


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
