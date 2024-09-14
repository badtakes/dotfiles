{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.extra) mkEnableOption;

  cfg = config.modules.programs.zsh;
in {
  options.modules.programs.zsh = {
    enable = mkEnableOption "Enables Z shell (Zsh)";
  };

  config = mkIf cfg.enable {
    programs.zsh.enable = true;

    environment.pathsToLink = ["/share/zsh"];

    user = {
      shell = pkgs.zsh;

      home.programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = config.user.shellAliases;

        oh-my-zsh = {
          enable = true;
          plugins = [
            "aliases"
            "battery"
            "branch"
            "bun"
            "colored-man-pages"
            "command-not-found"
            "common-aliases"
            "copyfile"
            "copypath"
            "direnv"
            "docker-compose"
            "docker"
            "dotenv"
            "dotnet"
            "encode64"
            "extract"
            "eza"
            "gcloud"
            "genpass"
            "gh"
            "git-commit"
            "gitignore"
            "history"
            "kitty"
            "pre-commit"
            "sudo"
            "systemd"
            "tldr"
          ];
          theme = "bureau";
        };
      };
    };
  };
}
