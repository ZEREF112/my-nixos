{
  description = "MY-NIXOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, home-manager, dms, quickshell, zen-browser, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix
        ./modules/graphics.nix
        ./modules/services.nix
        ./modules/pkgs.nix
        ./modules/programs.nix

        # DankMaterialShell (SYSTEM LEVEL)
        dms.nixosModules.dankMaterialShell

        # Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.fouad = import ./home.nix;
        }

        ({ config, pkgs, ... }: {

          # ===============================
          # Kernel
          # ===============================
          boot.kernelPackages = pkgs.linuxPackages_latest;

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
