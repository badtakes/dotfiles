{
  environment.pathsToLink = ["/share/zsh"];

  programs.zsh = {
    enable = true;

    shellInit = ''
      # Make sure we always use the correct zsh dotdir.
      export ZDOTDIR=$HOME/.config/zsh
    '';

    enableCompletion = false;
  };
}
