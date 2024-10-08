{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  extensions = [
    "appindicator"
    "blur-my-shell"
    "clipboard-indicator"
    "dash-to-dock"
    "no-title-bar"
    "system-monitor"
    "user-themes"
  ];

  cfg = osConfig.services.xserver.desktopManager.gnome;
in {
  config = let
    extensionPkgs = builtins.map (x: pkgs.gnomeExtensions.${x}) extensions;
  in
    mkIf cfg.enable {
      dconf.settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = builtins.map (pkg: pkg.extensionUuid) extensionPkgs;
        };
      };

      home.packages = extensionPkgs;
    };
}
