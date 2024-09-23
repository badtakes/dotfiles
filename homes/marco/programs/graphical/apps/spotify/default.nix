{
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.system};
in {
  imports = [inputs.spicetify.homeManagerModules.default];

  config = {
    programs.spicetify = {
      enable = true;

      enabledExtensions = with spicePkgs.extensions; [
        hidePodcasts
        songStats
        shuffle
        history
        betterGenres
      ];

      theme = spicePkgs.themes.text;
    };
  };
}
