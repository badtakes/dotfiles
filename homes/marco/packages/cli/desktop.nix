{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      libnotify
      imagemagick
      bitwarden-cli
      trash-cli
      slides
      brightnessctl
      pamixer
      nix-tree
    ];
  };
}
