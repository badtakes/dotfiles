{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf false {
    xdg.portal = {
      enable = true;

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];

      config = {
        common = let
          portal = "hyprland";
        in {
          default = ["gtk"];

          # for flameshot to work
          # https://github.com/flameshot-org/flameshot/issues/3363#issuecomment-1753771427
          "org.freedesktop.impl.portal.Screencast" = ["${portal}"];
          "org.freedesktop.impl.portal.Screenshot" = ["${portal}"];
        };
      };

      # xdg-desktop-wlr (this section) is no longer needed, xdg-desktop-portal-hyprland
      # will (and should) override this one
      # however in case I run a different compositor on a Wayland host, it can be enabled
      # wlr = {
      #   # enable = mkForce (env.isWayland && env.desktop != "Hyprland");
      #   enable = mkForce false;
      #   settings = {
      #     screencast = {
      #       max_fps = 30;
      #       chooser_type = "simple";
      #       chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
      #     };
      #   };
      # };
    };
  };
}
