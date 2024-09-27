{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    disabledPlugins = ["sap"];

    settings = {
      General = {
        AutoConnect = "true";
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
        FastConnectable = "true";
        MultiProfile = "multiple";
        JustWorksRepairing = "always";
      };
    };
  };

  hardware.pulseaudio.extraModules = [pkgs.pulseaudio-modules-bt];
  hardware.pulseaudio.extraConfig = ''
    load-module module-switch-on-connect

    unload module-bluetooth-policy
    load-module module-bluetooth-policy auto_switch=2

    unload module-bluetooth-discover
    load-module module-bluetooth-discover headset=native
  '';

  services.blueman.enable = true;
}
