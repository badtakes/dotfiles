{config, ...}: {
  imports = [
    ./aliases.nix
    ./init.nix
    ./plugins.nix
  ];

  config = {
    programs.zsh = {
      enable = true;

      dotDir = ".config/zsh";

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history = {
        share = true;

        path = "${config.xdg.dataHome}/zsh/zsh_history";

        extended = true;

        save = 100000;
        size = 100000;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
        ignorePatterns = ["rm *" "pkill *" "kill *" "killall *"];
      };

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

      envExtra = ''
        setopt no_global_rcs
      '';
    };
  };
}
