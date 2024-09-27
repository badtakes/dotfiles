{lib, ...}: let
  quantum = 64;
  rate = 96000;
in {
  config = {
    security.rtkit.enable = lib.mkDefault true;

    services.pipewire = {
      enable = true;
      audio.enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };

      pulse.enable = true;
      jack.enable = true;

      extraConfig.pipewire."99-lowlatency" = {
        context.properties.default.clock.min-quantum = quantum;
      };

      extraConfig.pipewire-pulse."99-lowlatency" = let
        qr = "${toString quantum}/${toString rate}";
      in {
        context.modules = [
          {
            name = "libpipewire-module-rtkit";
            args = {
              nice.level = -15;
              rt.prio = 88;
              rt.time.soft = 200000;
              rt.time.hard = 200000;
            };
            flags = ["ifexists" "nofail"];
          }
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = qr;
              pulse.min.quantum = qr;
              pulse.min.frag = qr;
              server.address = ["unix:native"];
            };
          }
        ];

        stream.properties = {
          node.lowlatency = qr;
          resample.quanlity = 1;
        };
      };
    };
  };
}
