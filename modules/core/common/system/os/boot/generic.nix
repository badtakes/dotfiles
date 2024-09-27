{lib, ...}: let
  inherit (lib) mkDefault;
in {
  config = {
    boot = {
      tmp.cleanOnBoot = true;

      loader = {
        efi.canTouchEfiVariables = true;
        generationsDir.copyKernels = true;
      };
    };
  };
}
