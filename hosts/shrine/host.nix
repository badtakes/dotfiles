{...}: {
  config = {
    boot.loader.systemd-boot.enable = true;

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/c6eaa438-a841-467e-a5f7-236ddff5657d";
        fsType = "ext4";
      };

      "/boot" = {
        device = "/dev/disk/by-uuid/6E82-F2C2";
        fsType = "vfat";
      };
    };

    system.stateVersion = "23.11";
  };
}
