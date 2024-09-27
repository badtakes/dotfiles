{
  pkgs,
  lib,
  ...
}: {
  programs.bash = {
    interactiveShellInit = ''
      export HISTFILE="$XDG_STATE_HOME"/bash_history
    '';

    promptInit = ''
      eval "$(${lib.getExe pkgs.starship} init bash)"
    '';
  };
}
