{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkDefault mkIf;
  inherit (lib.options) mkEnableOption mkPackageOption;

  cfg = config.modules.window-managers.sway;
in {
  options.modules.window-managers.sway = {
    enable = mkEnableOption "Sway";
    package = mkPackageOption pkgs "Sway" {default = ["swayfx"];};
  };

  config = mkIf cfg.enable {
    security.polkit.enable = mkDefault true;

    environment.systemPackages = with pkgs; [
      grim
      slurp
      wl-clipboard
      mako
    ];

    programs.sway = {
      enable = true;
      package = cfg.package;

      wrapperFeatures.gtk = true;
    };
  };
}
