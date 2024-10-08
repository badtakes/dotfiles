{
  config,
  inputs',
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  package = inputs'.hyprland.packages.hyprland;
  portalPackage = inputs'.hyprland.packages.xdg-desktop-portal-hyprland;

  cfg = config.modules.window-managers.hyprland;
in {
  options.modules.window-managers.hyprland = {
    enable = mkEnableOption "Hyprland";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      inherit package portalPackage;

      enable = true;
      xwayland.enable = true;
    };
  };
}
