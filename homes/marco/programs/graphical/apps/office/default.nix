{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf true {
    home.packages = with pkgs; [
      libreoffice-qt
      hyphen # text hyphenation library
      hunspell
      hunspellDicts.en_US-large
      hunspellDicts.en_GB-large
      hunspellDicts.pt_BR
    ];
  };
}
