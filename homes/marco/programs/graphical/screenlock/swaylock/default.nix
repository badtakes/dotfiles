{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      datestr = "%d/%m/%Y";
      fade-in = "0.1";
      font = "Work Sans";
      font-size = 24;
      grace = 3;
      grace-no-mouse = true;
      grace-no-touch = true;
      ignore-empty-password = true;
      indicator = true;
      indicator-idle-visible = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      line-uses-ring = false;
      show-failed-attempts = false;
    };
  };
}
