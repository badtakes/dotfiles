{
  config,
  inputs,
  pkgs,
  ...
}: let
  spice = inputs.spicetify.legacyPackages.${pkgs.stdenv.system};
in {
  imports = [inputs.spicetify.homeManagerModules.default];

  config = {
    programs.spicetify = {
      enable = true;
      windowManagerPatch = true;

      theme =
        spice.themes.sleek
        // {
          additionalCss = "* { font-family: ${config.stylix.fonts.sansSerif.name} !important } ";
        };

      colorScheme = "rosepine";

      enabledExtensions = with spice.extensions; [
        beautifulLyrics
        betterGenres
        goToSong
        history
        loopyLoop
        playNext
        popupLyrics
        seekSong
        showQueueDuration
        volumePercentage
      ];

      enabledCustomApps = with spice.apps; [
        betterLibrary
        localFiles
        newReleases
      ];
    };
  };
}
