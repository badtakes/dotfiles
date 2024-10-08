{
  config,
  inputs',
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.modules.system.bluetooth;
in {
  options.modules.system.bluetooth = {
    enable = mkEnableOption "Enable Bluetooth support";
  };

  config = let
    bluetui = inputs'.bluetui.packages.default;
  in
    mkIf cfg.enable {
      user.packages = [bluetui];

      services.blueman.enable = true;

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;

        package = pkgs.bluez-experimental;

        settings = {
          General = {
            MultiProfile = "multiple";
            FastConnectable = "true";
            Experimental = "true";
            ResumeDelay = "4";
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
    };
}
