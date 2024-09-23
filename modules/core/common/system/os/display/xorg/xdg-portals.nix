{
  pkgs,
  lib,
  ...
}: {
  config = {
    xdg.portal = lib.mkIf false {
      enable = true;

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
