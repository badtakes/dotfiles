{lib, ...}: {
  imports = [
    ./encryption.nix
    ./generic.nix
    ./kernel.nix
  ];

  config = {
    boot = {
      swraid.enable = lib.mkDefault false;

      loader = {
        efi.canTouchEfiVariables = true;
        generationsDir.copyKernels = true;

        systemd-boot = {
          enable = true;
          editor = false;
          configurationLimit = null;
        };
      };

      tmp.cleanOnBoot = true;
    };

    systemd.targets.network-online.wantedBy = lib.mkForce [];
    systemd.services.NetworkManager-wait-online.wantedBy = lib.mkForce [];
  };
}
