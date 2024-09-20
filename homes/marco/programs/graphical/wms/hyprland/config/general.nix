{...}: let
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
  wayland.windowManager.hyprland.settings = {
    general = {
      # sensitivity of the mouse cursor
      sensitivity = 0.8;

      # gaps
      gaps_in = 4;
      gaps_out = 8;

      # border thiccness
      border_size = 2;

      # active border color
      "col.active_border" = "0xff${colors.base07}";

      # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
      apply_sens_to_raw = 0;
    };
  };
}
