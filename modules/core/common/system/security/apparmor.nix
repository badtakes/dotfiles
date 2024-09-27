{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault;
in {
  config = {
    security.apparmor = {
      enable = mkDefault true;
      killUnconfinedConfinables = mkDefault true;
      packages = with pkgs; [apparmor-profiles];
    };
  };
}
