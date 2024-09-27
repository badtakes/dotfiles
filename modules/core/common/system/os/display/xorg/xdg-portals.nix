{lib, ...}: {
  config = {
    xdg.portal = lib.mkIf true {
      enable = true;

      # extraPortals = [
      #   pkgs.xdg-desktop-portal-gtk
      # ];
    };
  };
}
