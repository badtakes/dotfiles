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
    theme = "rose-pine";
    scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
  in {
    inherit scheme;

    stylix = {
      enable = true;

      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/wallpapers/nix-wallpaper-binary-black_8k.png";
        sha256 = "sha256-MxEgvzWmdqMeI5GeI6Hzci6yd5iL44NDXyKQOuw+fLY=";
      };
      imageScalingMode = "center";

      polarity = "dark";

      base16Scheme = scheme;

      cursor = {
        package = pkgs.rose-pine-cursor;
        name = "BreezeX-RosePine-Linux";
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
          name = "Lexend";
          package = pkgs.lexend;
        };
      };

      targets = {
        vscode.enable = mkForce false;
      };
    };
  };
}
