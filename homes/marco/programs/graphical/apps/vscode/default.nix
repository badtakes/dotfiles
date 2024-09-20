{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkForce;
in {
  config = {
    programs.vscode = {
      package = pkgs.vscode-fhs;

      enable = true;
      enableUpdateCheck = true;
      enableExtensionUpdateCheck = true;

      extensions = mkForce [];
      userSettings = mkForce {};
    };
  };
}
