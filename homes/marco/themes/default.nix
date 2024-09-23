{pkgs, ...}: {
  imports = [
    ./gtk.nix
    ./qt.nix
    ./global.nix
  ];
  config = let
    theme = "catppuccin-mocha";
    scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
  in {
    inherit scheme;

    stylix = {
      enable = true;
      autoEnable = false;

      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/wallpapers/nix-wallpaper-binary-black_8k.png";
        sha256 = "sha256-MxEgvzWmdqMeI5GeI6Hzci6yd5iL44NDXyKQOuw+fLY=";
      };
      imageScalingMode = "center";

      polarity = "dark";

      base16Scheme = scheme;

      cursor = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors-light";
      };

      fonts = {
        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-color-emoji;
        };
        monospace = {
          name = "Iosevka Nerd Font";
          package = pkgs.nerdfonts.override {fonts = ["Iosevka" "JetBrainsMono" "NerdFontsSymbolsOnly"];};
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
        bat.enable = true;
        btop.enable = true;
        fzf.enable = true;
        gnome.enable = true;
        gtk.enable = true;
        kde.enable = true;
        mako.enable = true;
        tmux.enable = true;
        tofi.enable = true;
        vesktop.enable = true;
        vscode.enable = true;
        wezterm.enable = true;
        wofi.enable = true;
        zathura.enable = true;
      };
    };
  };
}
