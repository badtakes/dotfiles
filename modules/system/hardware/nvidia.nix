{
  config,
  pkgs,
  ...
}: {
  config = {
    boot.blacklistedKernelModules = ["i915"];

    services.xserver.videoDrivers = ["nvidia"];

    environment = {
      systemPackages = with pkgs; [libva];

      sessionVariables = {
        LIBVA_DRIVER_NAME = "nvidia";
        WLR_NO_HARDWARE_CURSORS = "1";

        GBM_BACKEND = "nvidia-drm";

        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      };
    };

    hardware = {
      nvidia = {
        modesetting.enable = true;

        powerManagement.enable = true;
        # powerManagement.finegrained = true;

        nvidiaSettings = true;

        package = config.boot.kernelPackages.nvidiaPackages.production;
      };

      graphics = {
        extraPackages = with pkgs; [nvidia-vaapi-driver];
        extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver];
      };
    };
  };
}
