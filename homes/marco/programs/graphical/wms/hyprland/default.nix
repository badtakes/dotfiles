{
  inputs',
  pkgs,
  lib,
  ...
}: let
  inherit (builtins) filter map toString;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.modules) mkIf;
  inherit (lib.strings) hasSuffix;

  inherit (import ./packages {inherit inputs' pkgs;}) grimblast hyprshot dbus-hyprland-env hyprpicker;

  hyprlandPackage = inputs'.hyprland.packages.hyprland;
in {
  imports = filter (hasSuffix ".nix") (
    map toString (filter (p: p != ./default.nix) (listFilesRecursive ./config))
  );
  config = mkIf true {
    home.packages = [
      hyprshot
      grimblast
      hyprpicker
      dbus-hyprland-env
    ];

    wayland.windowManager.hyprland = {
      enable = false;
      package = hyprlandPackage;
      xwayland.enable = true;
      systemd = {
        enable = true;
        variables = ["--all"];
      };
    };
  };
}