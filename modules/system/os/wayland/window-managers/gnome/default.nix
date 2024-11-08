{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.options) mkEnableOption;

  cfg = config.modules.windowManager.gnome;
in {
  options.modules.windowManager.gnome = {
    enable = mkEnableOption "Gnome";
  };

  config = mkIf cfg.enable {
    chaotic.appmenu-gtk3-module.enable = true;

    services.xserver = {
      enable = mkDefault true;
      desktopManager.gnome.enable = true;

      displayManager = {
        gdm = {
          enable = mkDefault true;
        };
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

    systemd.user.services = {
      xmousepasteblock = {
        name = "xmousepasteblock";
        description = "Block mouse paste in X11";

        script = "${pkgs.xmousepasteblock}/bin/xmousepasteblock";
      };
    };
  };
}
