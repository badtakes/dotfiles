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

      enableVteIntegration = true;

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
