{pkgs, ...}: let
  colors = {
    base00 = "#1e1e2e"; # Base
    base01 = "#181825"; # Mantle
    base02 = "#313244"; # Surface0
    base03 = "#45475a"; # Surface1
    base04 = "#585b70"; # Surface2
    base05 = "#cdd6f4"; # text
    base06 = "#f5e0dc"; # rosewater
    base07 = "#b4befe"; # lavender
    base08 = "#f38ba8"; # red
    base09 = "#fab387"; # peach
    base0A = "#a6e3a1"; # yellow
    base0B = "#94e2d5"; # green
    base0C = "#94e2d5"; # teal
    base0D = "#89b4fa"; # blue
    base0E = "#cba6f7"; # mauve
    base0F = "#f2cdcd"; # flamingo
  };
in {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      color = "${colors.base00}";
      font = "Work Sans";
      show-failed-attempts = false;
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      line-color = "${colors.base00}";
      ring-color = "${colors.base04}";
      inside-color = "${colors.base00}";
      key-hl-color = "${colors.base0F}";
      separator-color = "00000000";
      text-color = "${colors.base05}";
      text-caps-lock-color = "";
      line-ver-color = "${colors.base0F}";
      ring-ver-color = "${colors.base0F}";
      inside-ver-color = "${colors.base00}";
      text-ver-color = "${colors.base05}";
      ring-wrong-color = "${colors.base08}";
      text-wrong-color = "${colors.base08}";
      inside-wrong-color = "${colors.base00}";
      inside-clear-color = "${colors.base00}";
      text-clear-color = "${colors.base05}";
      ring-clear-color = "${colors.base0B}";
      line-clear-color = "${colors.base00}";
      line-wrong-color = "${colors.base00}";
      bs-hl-color = "${colors.base08}";
      line-uses-ring = false;
      grace = 3;
      grace-no-mouse = true;
      grace-no-touch = true;
      datestr = "%d/%m/%Y";
      fade-in = "0.1";
      ignore-empty-password = true;
    };
  };
}
