{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  # imports = [./config.nix];
  config = mkIf false {
    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.swayfx;
    };
  };
}
