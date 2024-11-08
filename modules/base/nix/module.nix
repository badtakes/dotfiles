{
  self,
  lib,
  pkgs,
  ...
}: let
  mkNixCache = cacheUrl: cacheKey: {inherit cacheUrl cacheKey;};
in {
  imports = [
    ./overlays

    ./documentation.nix
  ];

  options = {};
  config = let
    caches = let
      nixos = mkNixCache "https://cache.nixos.org" "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
      community = mkNixCache "https://nix-community.cachix.org" "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
      unfree = mkNixCache "https://nixpkgs-unfree.cachix.org" "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs=";

      cachix = mkNixCache "https://cachix.cachix.org" "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM=";
      wayland = mkNixCache "https://nixpkgs-wayland.cachix.org" "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA=";
      hyprland = mkNixCache "https://hyprland.cachix.org" "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=";

      irancho = mkNixCache "http://nix-cache.irancho.com.br" "nix-cache.irancho.com.br:HvCdS6lKTt7MTMnBLfcGAVqmroQiEV1j36tbNr0YM98=";
    in [nixos community unfree cachix wayland hyprland irancho];

    substituters = map (c: c.cacheUrl) caches;
    trusted-public-keys = map (c: c.cacheKey) caches;
  in {
    nix = {
      package = pkgs.nixVersions.latest;

      daemonCPUSchedPolicy = "idle";
      daemonIOSchedClass = "idle";
      daemonIOSchedPriority = 7;

      # gc = {
      #   automatic = true;
      #   dates = "Sat *-*-* 03:00";
      #   options = "--delete-older-than 30d";
      #   persistent = false;
      # };

      optimise = {
        automatic = true;
        dates = ["04:00"];
      };

      settings = {
        inherit substituters trusted-public-keys;

        min-free = "${toString (5 * 1024 * 1024 * 1024)}";
        max-free = "${toString (10 * 1024 * 1024 * 1024)}";

        experimental-features = "nix-command flakes";

        allowed-users = lib.mkForce ["root" "@wheel"];
        trusted-users = lib.mkForce ["root" "@wheel"];

        max-jobs = "auto";
      };
    };

    nixpkgs = {
      config = {
        allowAliases = true;
        allowBroken = false;
        allowUnfree = true;
        allowUnsupportedSystem = true;
        enableParallelBuildingByDefault = false;
        permittedInsecurePackages = [];
        showDerivationWarnings = [];
      };
    };

    system = {
      autoUpgrade.enable = false;
      configurationRevision = self.shortRev or self.dirtyShortRev;
    };

    environment.etc."dotfiles".source = self;

    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 30d --keep 5";
      flake = "/home/marco/.config/dotfiles";
    };
  };
}
