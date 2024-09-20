{
  inputs,
  pkgs,
  ...
}: let
  hyprlandPkg = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  hyprlandPortalPkg = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
in {
  # disables Nixpkgs Hyprland module to avoid conflicts
  disabledModules = ["programs/hyprland.nix"];

  config = {
    services.displayManager.sessionPackages = [hyprlandPkg];

    xdg.portal = {
      enable = true;
      configPackages = [hyprlandPkg];
      extraPortals = [
        (hyprlandPortalPkg.override {
          hyprland = hyprlandPkg;
        })
      ];
    };
  };
}
