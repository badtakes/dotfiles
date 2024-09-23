{
  lib,
  pkgs,
  ...
}: {
  config = {
    programs.vscode = {
      package = pkgs.vscode-fhs;

      enable = true;
      enableUpdateCheck = true;
      enableExtensionUpdateCheck = true;

      extensions = lib.mkForce [];
      userSettings = lib.mkForce {};
    };
  };
}
