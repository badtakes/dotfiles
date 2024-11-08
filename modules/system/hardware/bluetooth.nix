{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkMerge mkEnableOption;

  audio = config.modules.audio;
  cfg = config.modules.bluetooth;
in {
  options.modules.bluetooth = {
    enable = mkEnableOption "Enable Bluetooth support";
  };

  config = mkIf cfg.enable (
    mkMerge [
      {
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
      }

      (mkIf audio.enable {
        services.pipewire.wireplumber.extraConfig = {
          "10-bluez" = {
            "monitor.bluez.properties" = {
              "bluez5.enable-hw-volume" = true;
            };
          };

          "11-bluetooth-policy" = {
            "wireplumber.settings" = {
              "bluetooth.autoswitch-to-headset-profile" = false;
            };
          };
        };
      })
    ]
  );
}
