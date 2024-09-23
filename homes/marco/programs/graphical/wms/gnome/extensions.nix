{pkgs, ...}: let
  extensions = [
    "appindicator"
    "blur-my-shell"
    "clipboard-indicator"
    "dash-to-dock"
    "vitals"
  ];
in {
  config = let
    extensionPkgs = builtins.map (x: pkgs.gnomeExtensions.${x}) extensions;
  in {
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = builtins.map (pkg: pkg.extensionUuid) extensionPkgs;
      };
    };

    home.packages = extensionPkgs;
  };
}
