{
  config,
  pkgs,
  ...
}: {
  config = {
    services.xserver.videoDrivers = ["nvidia"];

    boot.initrd.kernelModules = ["nvidia" "nvidia_modeset" "nvidia-uvm" "nvidia_drm"];
    boot.blacklistedKernelModules = ["i915"];

    boot.kernelParams = [
      "rcutree.rcu_idle_gp_delay=1"
      "acpi_osi=!"
      "acpi_osi='Linux'"
      "pcie_aspm=off"
    ];

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
        package = config.boot.kernelPackages.nvidiaPackages.production;

        modesetting.enable = true;
        powerManagement.enable = true;
      };

      graphics = {
        extraPackages = with pkgs; [nvidia-vaapi-driver];
        extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver];
      };
    };
  };
}
