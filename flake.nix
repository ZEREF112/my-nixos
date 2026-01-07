{
  description = "MY-NIXOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

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

  outputs = { self, nixpkgs, dms, zen-browser, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs zen-browser; };

      modules = [
        ./configuration.nix
        dms.nixosModules.default

        ./modules/graphics.nix
        ./modules/services.nix
        ./modules/apps.nix

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
