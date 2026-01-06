
{ ... }:

{
  # ===============================
  # Asus Laptop Services
  # ===============================
  services.supergfxd.enable = true;
  services.asusd.enable = true;

  # ===============================
  # Core Services
  # =============================== 
  services.flatpak.enable = true;
  services.tuned.enable = true;

  virtualisation.libvirtd.enable = true;
}
