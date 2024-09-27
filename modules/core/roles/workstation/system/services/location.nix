{lib, ...}: {
  location.provider = lib.mkForce "geoclue2";
  services.geoclue2.enable = true;
}
