{
  lib,
  osConfig,
  pkgs,
  self',
  ...
}: let
  inherit (lib.modules) mkIf;

  dbus-sway-environment = self'.packages.dbus-sway-environment;
  configure-gtk = self'.packages.configure-gtk;

  cfg = osConfig.modules.windowManager.sway;
in {
  imports = [
    ./keybindings.nix
    ./status-bar.nix
  ];

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.libappindicator

      dbus-sway-environment
      configure-gtk
    ];

    wayland.windowManager.sway = {
      enable = true;
      package = cfg.package;

      systemd.xdgAutostart = true;
      checkConfig = false;

      config = {
        modifier = cfg.modifier;

        bars = [
          {command = "${pkgs.waybar}/bin/waybar";}
        ];

        gaps = {
          smartBorders = "on";
          outer = 5;
          inner = 5;
        };

        window = {
          titlebar = false;
          commands = let
            mkCmds = cmds: criteria:
              builtins.map (cmd: {
                inherit criteria;
                command = cmd;
              })
              cmds;
          in
            (mkCmds [
              "border pixel 0"
              "dim_inactive"
            ] {app_id = "^.*";})
            ++ [];
        };

        workspaceAutoBackAndForth = true;

        startup = [
          {command = "${dbus-sway-environment}/bin/dbus-sway-environment";}
          {command = "${configure-gtk}/bin/configure-gtk";}
        ];

        input = {
          "type:keyboard" = {
            repeat_delay = "300";
            repeat_rate = "20";
          };

          "type:touchpad" = {
            tap = "enabled";
            natural_scroll = "enabled";
            middle_emulation = "enabled";
          };

          "1:1:AT_Translated_Set_2_keyboard" = {
            "xkb_layout" = "br";
            "xkb_variant" = "abnt2";
          };

          "1133:50504:Logitech_USB_Receiver" = {
            "xkb_layout" = "us";
            "xkb_variant" = "alt-intl";
          };
        };
      };

      swaynag.enable = true;
    };
  };
}
