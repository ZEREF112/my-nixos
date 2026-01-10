
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
  services.dbus.enable = true;
  security.polkit.enable = true;
  services.flatpak.enable = true;
  services.tuned.enable = true;

  services.pipewire = {
  enable = true;
  alsa.enable = true;
  pulse.enable = true;
};

  virtualisation.libvirtd.enable = true;
}
