{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  spice = inputs.spicetify.legacyPackages.${pkgs.stdenv.system};
in {
  imports = [inputs.spicetify.homeManagerModules.default];

  config = {
    programs.spicetify = {
      enable = true;

      theme = lib.mkDefault (spice.themes.dribbblish // {additionalCss = "* { font-family: ${config.stylix.fonts.sansSerif.name} !important } ";});
      colorScheme = lib.mkDefault "gruvbox-material-dark";

      enabledExtensions = with spice.extensions; [
        betterGenres
        volumePercentage
      ];

      enabledCustomApps = with spice.apps; [
        newReleases
      ];
    };
  };
}
