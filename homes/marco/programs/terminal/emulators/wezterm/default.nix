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
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
    colorSchemes = import ./colorSchemes.nix {inherit colors;};
    extraConfig = ''
      local wez = require("wezterm")
      local act = wezterm.action
      local baseConfig = {
       -- general
       check_for_updates = false, -- nix has updates covered, I don't care about updates
       exit_behavior = "CloseOnCleanExit",
       enable_scroll_bar = false,
       audible_bell = "Disabled", -- annoying
       warn_about_missing_glyphs =  false,

       -- anims
        animation_fps = 1,

       -- term window settings
       adjust_window_size_when_changing_font_size = false,
       window_background_opacity = 0.85,
       window_padding = { left = 12, right = 12, top = 12, bottom = 12, },
       window_close_confirmation = "NeverPrompt",
       inactive_pane_hsb = {
        saturation = 1.0,
        brightness = 0.8
       },

       -- cursor
       default_cursor_style = "SteadyBar",
       cursor_blink_rate = 700,
       cursor_blink_ease_in = 'Constant',
       cursor_blink_ease_out = 'Constant',

       -- tab bar
       enable_tab_bar = true, -- no observable performance impact
       use_fancy_tab_bar = false,
       hide_tab_bar_if_only_one_tab = true,
       show_tab_index_in_tab_bar = false,

       -- font config
       font_size = 14.0,
       font = wezterm.font_with_fallback {
        { family = "Iosevka Nerd Font", weight = "Regular" },
        { family = "Symbols Nerd Font", weight = "Regular" }
       },

       -- perf
       front_end = "WebGpu",
       enable_wayland = true,
       scrollback_lines = 10000,

       -- colors
       -- the followSystem theme is defined in colorSchemes.nix
       -- as per my base16 theming options
       color_scheme = "followSystem",
      }

      return baseConfig
    '';
  };
}
