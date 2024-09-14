{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.extra) mkEnableOption;

  cfg = config.modules.programs.kitty;
in {
  options.modules.programs.kitty = {
    enable = mkEnableOption "Enables Kitty terminal emulator.";
  };

  config = mkIf cfg.enable {
    user.home.programs.kitty = {
      enable = true;

      settings = {
        copy_on_select = true;
        disable_ligatures = "cursor";
        enable_audio_bell = false;
      };

      shellIntegration = {
        enableFishIntegration = config.modules.programs.fish.enable;
        enableZshIntegration = config.modules.programs.zsh.enable;
      };
    };
  };
}
