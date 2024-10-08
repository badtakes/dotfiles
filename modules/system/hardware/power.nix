{
  config,
  lib,
  ...
}: {
  boot.kernelModules = ["acpi_call"];
  boot.extraModulePackages = with config.boot.kernelPackages; [acpi_call];

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=60min
  '';

  services.upower.enable = true;

  services.tlp.enable = !config.services.xserver.desktopManager.gnome.enable;
  services.tlp.settings = lib.mkMerge [
    {
      DISK_IOSCHED = "bfq bfq";
      PLATFORM_PROFILE_ON_AC = "balanced";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
      START_CHARGE_TRESH_BAT0 = 0;
      STOP_CHARGE_TRESH_BAT0 = 1;
    }
    # TODO: only intel
    (lib.mkIf true {
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    })
  ];
}
