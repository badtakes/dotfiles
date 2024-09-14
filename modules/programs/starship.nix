{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.extra) mkEnableOption;

  cfg = config.modules.programs.starship;
in {
  options.modules.programs.starship = {
    enable = mkEnableOption "Enables starship.";
  };

  config = {
    user.home.programs.starship = {
      enable = cfg.enable;

      enableFishIntegration = config.modules.programs.fish.enable;
      enableZshIntegration = config.modules.programs.zsh.enable;

      settings =
        {
          format = "$all";
          palette = "catppuccin_mocha";
        }
        // builtins.fromTOML (builtins.readFile (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f";
            sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
          }
          + /palettes/mocha.toml));
    };
  };
}
