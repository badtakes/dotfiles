{lib, ...}: let
  inherit (lib) mkDefault;
in {
  security = {
    sudo.enable = true;
    sudo.wheelNeedsPassword = mkDefault false;
  };
}
