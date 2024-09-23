{
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf false {
    # Enable the i915 kernel module
    boot.initrd.kernelModules = ["i915"];

    # Provides better performance than the actual Intel driver
    services.xserver.videoDrivers = ["modesetting"];

    # OpenCL support and VAAPI
    hardware.graphics = {
      extraPackages = with pkgs; [
        # vaapiIntel
        (intel-vaapi-driver.override {enableHybridCodec = true;})
        vaapiVdpau
        intel-compute-runtime
        intel-media-driver
        libvdpau-va-gl
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        # vaapiIntel
        (intel-vaapi-driver.override {enableHybridCodec = true;})
        vaapiVdpau
        intel-media-driver
        libvdpau-va-gl
        # intel-compute-runtime # FIXME does not build due to unsupported system
      ];
    };
  };
}
