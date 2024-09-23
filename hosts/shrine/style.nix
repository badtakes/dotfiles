{pkgs, ...}: let
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/wallpapers/nix-wallpaper-binary-black_8k.png";
    sha256 = "sha256-MxEgvzWmdqMeI5GeI6Hzci6yd5iL44NDXyKQOuw+fLY=";
  };
in {
  config = {
    stylix = {
      enable = true;
      autoEnable = false;

      image = wallpaper;
      imageScalingMode = "center";

      polarity = "dark";

      base16Scheme = "${pkgs.base16-schemes}/share/themes/black-metal-venom.yaml";

      targets = {
        # NixOS
        gnome.enable = true;
        gtk.enable = true;
        nixos-icons.enable = true;

        # Home Manager
        # bat.enable = true;
        # btop.enable = true;
        # firefox.enable = true;
        # wezterm.enable = true;
        # zathura.enable = true;
      };
    };
  };
}
