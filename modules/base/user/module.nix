{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkStrOption mkStrsOption mkPkgOption mkPkgsOption;

  defaultUserShell = pkgs.zsh;

  cfg = config.user;
in {
  imports = [
    ./locale.nix
  ];

  options.user = {
    name = mkStrOption "The name of the user";

    description = mkStrOption "The description of the user";

    extraGroups = mkStrsOption "Extra groups for the user";

    packages = mkPkgsOption "Packages to install for the user";

    shell = mkPkgOption defaultUserShell "The shell to use for the user";
  };
  config = {
    environment.sessionVariables = {
      BROWSER = "google-chrome-stable";
    };

    users = {
      inherit defaultUserShell;

      allowNoPasswordLogin = false;
      enforceIdUniqueness = true;

      users.root.hashedPassword = "*";
      users.${cfg.name} = {
        inherit (cfg) name description extraGroups shell packages;

        isNormalUser = true;
        home = "/home/${cfg.name}";
      };
    };
  };
}
