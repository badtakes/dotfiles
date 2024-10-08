{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkForce;

  iosvmata = pkgs.stdenvNoCC.mkDerivation {
    pname = "iosvmata";
    version = "1.2.0";

    src = pkgs.fetchurl {
      url = "https://github.com/N-R-K/Iosvmata/releases/download/v1.2.0/Iosvmata-v1.2.0.tar.zst";
      hash = "sha256-Cq/bx+nc5sTHxb4GerpEHDmW7st835bQ6ihTOp20Ei4=";
    };

    nativeBuildInputs = [pkgs.zstd];

    phases = ["unpackPhase" "installPhase"];

    installPhase = ''
      runHook preInstall

      install_path=$out/share/fonts/truetype
      mkdir -p $install_path
      find Nerd -type f -name "*.ttf" -exec cp {} $install_path \;

      runHook postInstall
    '';

    meta = with lib; {
      homepage = "https://github.com/N-R-K/Iosvmata";
      description = "Custom Iosevka build somewhat mimicking PragmataPro";
      platforms = platforms.all;
    };
  };
in {
  imports = [
    ./gtk.nix
    ./qt.nix
    ./global.nix
  ];
  config = let
    theme = "gruvbox-material-dark-soft";
    scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
  in {
    stylix = {
      enable = true;

      image = ../wallpapers/rooftop.png;
      imageScalingMode = "center";

      polarity = "dark";

      base16Scheme = scheme;

      cursor = {
        package = pkgs.whitesur-cursors;
        name = "WhiteSur-cursors";
      };

      opacity = {
        popups = 0.9;
        terminal = 0.9;
      };

      fonts = {
        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-color-emoji;
        };
        monospace = {
          name = "Iosvmata";
          package = iosvmata;
        };
        serif = {
          name = "Noto Serif";
          package = pkgs.noto-fonts;
        };
        sansSerif = {
          name = "Work Sans";
          package = pkgs.work-sans;
        };
      };

      targets = {
        vscode.enable = mkForce false;
      };
    };
  };
}
