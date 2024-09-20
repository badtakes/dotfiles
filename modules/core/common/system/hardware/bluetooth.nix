{pkgs, ...}: {
  boot.kernelParams = ["btusb"];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    package = pkgs.bluez5-experimental;

    disabledPlugins = ["sap"];
    settings = {
      General = {
        JustWorksRepairing = "always";
        MultiProfile = "multiple";
        Experimental = true;
      };
    };
  };

  services.blueman.enable = true;
}
