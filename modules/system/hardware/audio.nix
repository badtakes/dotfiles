{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkMerge mkIf mkDefault mkEnableOption mkOption types;

  cfg = config.modules.audio;
in {
  options.modules.audio = {
    enable = mkEnableOption "Enable audio support";
    realtime = mkEnableOption "Enable realtime audio";

    jack = mkOption {
      description = "Enable JACK emulation through PipeWire";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    user.extraGroups = let
      groups =
        if cfg.realtime
        then ["audio" "realtime"]
        else ["audio"];
    in
      groups;

    security.rtkit.enable = mkDefault true;

    environment.systemPackages = with pkgs; [
      pavucontrol
      qjackctl
    ];

    services.pipewire = mkMerge [
      {
        enable = true;
        audio.enable = true;

        alsa.enable = true;
        alsa.support32Bit = true;

        pulse.enable = true;
        jack.enable = cfg.jack;
      }

      # Useful commands:
      # $ pw-top                                                 see live stats
      # $ journalctl -b0 --user -u pipewire                      see logs (spa resync in "bad")
      # $ pw-metadata -n settings 0                              see current quantums
      # $ pw-metadata -n settings 0 clock.force-quantum 128      override quantum
      # $ pw-metadata -n settings 0 clock.force-quantum 0        disable override
      (mkIf cfg.realtime (let
        quantum = 96;
        rate = 48000;

        qr = "${toString quantum}/${toString rate}";
      in {
        extraConfig.pipewire."92-low-latency" = {
          "context.properties" = {
            "default.clock.rate" = rate;
            "default.clock.quantum" = quantum;
            "default.clock.min-quantum" = quantum;
            "default.clock.max-quantum" = quantum * 5;
          };

          "context.modules" = [
            {
              name = "libpipewire-module-rtkit";
              args = {
                "nice.level" = -15;
                "rt.prio" = 88;
                "rt.time.soft" = 200000;
                "rt.time.hard" = 200000;
              };
            }
          ];

          "jack.properties" = {
            node.quantum = qr;
          };
        };
      }))
    ];
  };
}
