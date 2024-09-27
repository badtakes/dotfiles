{pkgs, ...}: {
  config = {
    programs.taskwarrior = {
      enable = true;
      package = pkgs.taskwarrior3;

      dataLocation = "$XDG_DATA_HOME/.task";
      config = {
        confirmation = false;
      };
    };
  };
}
