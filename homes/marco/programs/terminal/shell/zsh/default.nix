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
        docs = "$HOME/Documents";
        dl = "$HOME/Downloads";
        media = "$HOME/Media";
        videos = "$HOME/Media/Videos";
        music = "$HOME/Media/Music";
        pics = "$HOME/Media/Pictures";
        screenshots = "$HOME/Media/Pictures/Screenshots";
        notes = "$HOME/Cloud/Notes";
        dotfiles = "$HOME/.config/dotfiles";
      };

      envExtra = ''
        setopt no_global_rcs
      '';
    };
  };
}
