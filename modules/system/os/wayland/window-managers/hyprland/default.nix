{
  config,
  inputs',
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.options) mkEnableOption;

  package = inputs'.hyprland.packages.hyprland;
  portalPackage = inputs'.hyprland.packages.xdg-desktop-portal-hyprland;

  cfg = config.modules.windowManager.hyprland;
in {
  options.modules.windowManager.hyprland = {
    enable = mkEnableOption "Hyprland";
  };

  config = mkIf cfg.enable {
    security.polkit.enable = mkDefault true;

    environment.systemPackages = with pkgs; [
      grim
      slurp
      wl-clipboard
      mako
    ];

    programs.hyprland = {
      inherit package portalPackage;

      enable = true;
      xwayland.enable = true;
    };

    xdg.portal = {
      extraPortals = (with pkgs; [wdg-desktop-portal-gtk]) ++ [portalPackage];

      config = {
        common = {
          # for flameshot to work
          # https://github.com/flameshot-org/flameshot/issues/3363#issuecomment-1753771427
          "org.freedesktop.impl.portal.ScreenCast" = ["hyprland"];
          "org.freedesktop.impl.portal.Screenshot" = ["hyprland"];
        };
      };
    };
  };
}
