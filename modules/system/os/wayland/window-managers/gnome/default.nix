{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.options) mkEnableOption;

  cfg = config.modules.window-managers.gnome;
in {
  options.modules.window-managers.gnome = {
    enable = mkEnableOption "Gnome";
  };
  config = mkIf cfg.enable {
    programs.dconf.enable = true;

    services.xserver = {
      enable = mkDefault true;
      desktopManager.gnome.enable = true;

      displayManager = {
        startx.enable = true;
        gdm.enable = mkDefault true;
      };
    };

    environment.gnome.excludePackages = with pkgs; [
      cheese
      epiphany
      geary
      gedit
      gnome-characters
      gnome-music
      gnome-photos
      gnome-tour
      yelp
    ];
  };
}
