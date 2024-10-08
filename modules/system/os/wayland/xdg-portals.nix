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

          # for flameshot to work
          # https://github.com/flameshot-org/flameshot/issues/3363#issuecomment-1753771427
          # "org.freedesktop.impl.portal.ScreenCast" = ["hyprland"];
          # "org.freedesktop.impl.portal.Screenshot" = ["hyprland"];
        };
      };
    };
  };
}
