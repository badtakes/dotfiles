{...}: {
  imports = [
    ./history.nix
    ./aliases.nix
    ./init.nix
    ./plugins.nix
  ];

  config = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      dotDir = ".config/zsh";

      dirHashes = {
        dl = "$HOME/Downloads";
        docs = "$HOME/Documents";
        dotfiles = "$HOME/.config/dotfiles";
        media = "$HOME/Media";
        music = "$HOME/Media/Music";
        pics = "$HOME/Media/Pictures";
        projects = "$HOME/Projects";
        screenshots = "$HOME/Media/Pictures/Screenshots";
        videos = "$HOME/Media/Videos";
      };

      oh-my-zsh = {
        enable = true;

        plugins = [
          "branch"
          "bun"
          "colored-man-pages"
          "copyfile"
          "copypath"
          "direnv"
          "docker-compose"
          "docker"
          "dotnet"
          "extract"
          "gcloud"
          "genpass"
          "gh"
          "gitignore"
          # "history"
          "postgres"
          "pre-commit"
          "ssh"
          "starship"
          "stripe"
          "sudo"
          "systemd"
          "taskwarrior"
          "terraform"
          "tldr"
          # "tmux"
          "web-search"
        ];

        theme = "eastwood";
      };

      envExtra = ''
        setopt no_global_rcs
      '';
    };
  };
}
