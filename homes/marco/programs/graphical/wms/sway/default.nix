{
  lib,
  osConfig,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.programs.sway;
in {
  imports = [
    ./keybindings.nix
    ./swaybar.nix
  ];

  config = mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;
      package = cfg.package;

      config = {
        # assigns = {
        #   "1: web" = [{class = "^Firefox$";}];
        #   "9: steam" = [{class = "^Steam$";}];
        # };

        bars = [
          {statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs";}
        ];

        gaps = {
          smartBorders = "on";
          outer = 5;
          inner = 5;
        };

        workspaceAutoBackAndForth = true;

        modifier = "Mod4";

        # keycodebindings = {
        #   "--locked --no-repeat 121" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; # mute
        #   "--locked 122" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 6%-"; # vol-
        #   "--locked 123" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 6%+"; # vol+
        #   "--locked 171" = "exec playerctl next"; # next song
        #   "--locked --no-repeat 172" = "exec playerctl play-pause"; # play/pause
        #   "--locked 173" = "exec playerctl previous"; # prev song
        #   "--locked --no-repeat 198" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; # mic mute
        #   "--locked 232" = "exec light -U 5"; # brightness-
        #   "--locked 233" = "exec light -A 5"; # brightness+
        # };

        startup = [{command = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY";}];

        input = {
          "1:1:AT_Translated_Set_2_keyboard" = {
            "xkb_layout" = "br";
            "xkb_variant" = "abnt2";
          };

          "1133:50504:Logitech_USB_Receiver" = {
            "xkb_layout" = "us";
            "xkb_variant" = "alt-intl";
          };

          "type:touchpad" = {
            "tap" = "enabled";
            "natural_scroll" = "enabled";
          };
        };

        swaynag.enable = true;
      };
    };
  };
}
