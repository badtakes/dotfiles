{
  lib,
  pkgs,
  ...
}: {
  config = {
    programs.vscode = {
      package = pkgs.vscode.fhsWithPackages (ps: with ps; [rustup zlib openssl.dev pkg-config]);

      enable = true;
      enableUpdateCheck = true;
      enableExtensionUpdateCheck = true;

      extensions = lib.mkForce [];
      userSettings = lib.mkForce {};
    };
  };
}
