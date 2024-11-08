{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types;
  inherit (lib.modules) mkDefault mkIf;
  inherit (lib.options) mkOption mkEnableOption mkPackageOption;

  cfg = config.modules.windowManager.sway;
in {
  options.modules.windowManager.sway = {
    enable = mkEnableOption "Sway";
    package = mkPackageOption pkgs "Sway" {default = ["swayfx"];};

    modifier = mkOption {
      default = "Mod4";
      type = types.str;
      description = "Sway modifier key";
    };
  };

  config = mkIf cfg.enable {
    security.polkit.enable = mkDefault true;

    environment.systemPackages = with pkgs; [
      grim
      slurp
      wl-clipboard
      mako
    ];

    programs.sway = {
      enable = true;
      package = cfg.package;

      wrapperFeatures.gtk = true;
    };

    xdg.portal = {
      extraPortals = with pkgs; [
        wdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];

      config = {
        common = {
          # for flameshot to work
          # https://github.com/flameshot-org/flameshot/issues/3363#issuecomment-1753771427
          "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
          "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
        };
      };
    };
  };
}
