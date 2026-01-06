{
  description = "MY-NIXOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms.url = "github:AvengeMedia/DankMaterialShell";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, home-manager, dms, zen-browser, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix
        dms.nixosModules.default

        ({ config, pkgs, ... }: {

          # ===============================
          # Kernel (NVIDIA friendly)
          # ===============================
          boot.kernelPackages = pkgs.linuxPackages_latest;

          # ===============================
          # Hardware / Graphics
          # ===============================
          #services.xserver.videoDrivers = [ "nvidia" ];

          hardware.graphics = {
            enable = true;
            enable32Bit = true;
          };


          hardware.nvidia = {
           modesetting.enable = true;
           powerManagement.enable = true;
           powerManagement.finegrained = true;

           open = false;

           package = config.boot.kernelPackages.nvidiaPackages.stable;

           prime = {
             offload.enable = true;
             offload.enableOffloadCmd = true;

               intelBusId = "PCI:0:2:0";
               nvidiaBusId = "PCI:1:0:0";
           };
          };

          # ===============================
          # Asus Laptop Services
          # ===============================
          services.supergfxd.enable = true;
          services.asusd.enable = true;

          # ===============================
          # Core Services
          # ===============================
          virtualisation.libvirtd.enable = true;
          services.flatpak.enable = true;
          services.tuned.enable = true;

          # ===============================
          # Programs
          # ===============================
          programs.hyprland.enable = true;
          programs.firefox.enable = true;
          programs.virt-manager.enable = true;
          programs.steam.enable = true;
          programs.wireshark.enable = true;
          programs.firejail.enable = true;

          # ===============================
          # Steam / Wayland / NVIDIA Fixes
          # ===============================
          environment.sessionVariables = {
             NIXOS_OZONE_WL = "1";
             __GL_GSYNC_ALLOWED = "1";
             __GL_VRR_ALLOWED = "1";
          };

          programs.steam.extraEnv = {
             __NV_PRIME_RENDER_OFFLOAD = "1";
             __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          };


          # ===============================
          # System Packages
          # ===============================
          environment.systemPackages = with pkgs; [
            # Browsers
            brave
            zen-browser.packages.${system}.default

            # Internet & Downloader
            qbittorrent telegram-desktop thunderbird jdownloader localsend

            # Virtualization & Games
            virt-viewer spice-gtk
            wineWowPackages.stable winetricks
            protonup-qt lutris

            # System Tools
            fastfetch nvtop pciutils usbutils asusctl
            git wget vim emacs tcpdump gparted
            gnome-disk-utility cpu-x speedtest-cli

            # Productivity
            libreoffice obsidian vscodium netbeans neovim
            github-desktop pdfarranger gimp darktable
            remmina realvnc-vnc-viewer
          ];

          # ===============================
          # Nix Settings
          # ===============================
          nix.settings = {
            experimental-features = [ "nix-command" "flakes" ];
            auto-optimise-store = true;
          };

          nixpkgs.config.allowUnfree = true;

          # ===============================
          # User
          # ===============================
          users.users.fouad = {
            isNormalUser = true;
            extraGroups = [
              "wheel"
              "networkmanager"
              "video"
              "wireshark"
              "libvirtd"
              "kvm"
            ];
          };

        })
      ];
    };
  };
}
