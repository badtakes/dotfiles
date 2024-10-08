{
  config,
  lib,
  ...
}: let
  inherit (lib) mkMerge mkIf mkDefault mkEnableOption;

  cfg = config.modules.system.audio;
  bluetooth = config.modules.system.bluetooth;
in {
  options.modules.system.audio = {
    enable = mkEnableOption "Enable audio support";
    lowLatency = mkEnableOption "Enable low-latency audio";
  };

  config = mkIf cfg.enable {
    user.extraGroups = ["audio"];

    security.rtkit.enable = mkDefault true;

    services.pipewire = mkMerge [
      {
        enable = true;
        audio.enable = true;

        alsa.enable = true;
        alsa.support32Bit = true;

        pulse.enable = true;
        jack.enable = mkDefault false;
      }

      (mkIf cfg.lowLatency (let
        quantum = 32;
        rate = 48000;
      in {
        extraConfig.pipewire."92-low-latency" = {
          "context.properties" = {
            "default.clock.rate" = rate;
            "default.clock.quantum" = quantum;
            "default.clock.min-quantum" = quantum;
            "default.clock.max-quantum" = quantum;
          };
        };

        extraConfig.pipewire-pulse."92-low-latency" = let
          qr = "${toString quantum}/${toString rate}";
        in {
          context.modules = [
            {
              name = "libpipewire-module-protocol-pulse";
              args = {};
            }
          ];

          "pulse.properties" = {
            "pulse.min.req" = qr;
            "pulse.min.quantum" = qr;
            "pulse.max.req" = qr;
            "pulse.max.quantum" = qr;
            "pulse.default.req" = qr;

            "server.address" = ["unix:native"];
          };

          "stream.properties" = {
            "node.latency" = qr;
            "resample.quality" = 1;
          };
        };
      }))

      (mkIf bluetooth.enable {
        wireplumber.extraConfig = {
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
    ];
  };
}
