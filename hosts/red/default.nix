{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
  ];

  environment.systemPackages = with pkgs; [
    arion
    bat
    bintools
    bottom
    btop
    coreutils
    curl
    exfat
    eza
    fastfetch
    file
    fzf
    git
    glib
    jq
    libnotify
    mpv
    p7zip
    ripgrep
    tldr
    toybox
    unrar
    unzip
    wget
    zip
  ];

  # Services
  services = {
    gnome.gnome-keyring.enable = true;

    mysql = {
      enable = false;
      package = pkgs.mariadb;
    };

    # netbird.enable = true;

    redis.servers."redis" = {
      enable = true;
      port = 6379;
    };
  };

  programs = {
    adb.enable = true;
    command-not-found.enable = true;
  };

  modules = {
    programs = {
      git.enable = true;
      kitty.enable = true;

      nixvim = {
        enable = false;

        viAlias = true;
        vimAlias = true;
      };

      zed.enable = true;
      zsh.enable = true;
    };

    services = {
      docker = {
        enable = true;
        compose = true;
      };

      lgtm.enable = false;

      stylix = {
        enable = true;
        wallpaper = wallpapers/nixos-binary.png;
      };
    };
  };

  user = {
    name = "marco";
    description = "Marco Antônio";

    groups = ["adbusers" "docker" "networking" "video" "wheel" "kvm" "dialout"];

    shellAliases = {
      cat = "bat";
    };

    packages = with pkgs; let
      gcloud = google-cloud-sdk.withExtraComponents (with google-cloud-sdk.components; [
        gke-gcloud-auth-plugin
        kubectl
      ]);
    in [
      alejandra
      anydesk
      d2
      devenv
      dotnet-sdk_8
      gcloud
      gh
      jetbrains.datagrip
      jetbrains.rider
      netbird-ui
      nil
      nixd
      obsidian
      onlyoffice-bin
      postman
      shfmt
      signal-desktop
      spotify
      stremio
      tor-browser-bundle-bin
      ventoy-full
      zx
    ];

    home = {
      services.flameshot.enable = true;

      programs = {
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };

        google-chrome.enable = true;

        vscode = {
          enable = true;
          package = pkgs.vscode.fhs;

          extensions = lib.mkForce [];
          userSettings = lib.mkForce {};
        };
      };
    };
  };
}
