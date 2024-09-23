{
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf true {
    programs.dconf.enable = true;

    services.xserver = {
      enable = lib.mkDefault true;
      displayManager.gdm.enable = lib.mkDefault true;
      desktopManager.gnome.enable = true;
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
