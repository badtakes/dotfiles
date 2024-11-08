{lib, ...}: let
  inherit (lib) mkIf;
in {
  config = mkIf true {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;

      wlr.enable = true;

      config = {
        common = {
          default = ["gtk"];

          "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
        };
      };
    };
  };
}
