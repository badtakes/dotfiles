{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkForce;

  inherit (config.stylix) fonts;
  inherit (config.lib.stylix) colors;
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi.override {
      plugins = [
        pkgs.rofi-calc
        # pkgs.rofi-rbw
        pkgs.rofi-emoji
      ];
    };

    extraConfig = {
      modi = "drun,filebrowser,calc,emoji";
      drun-display-format = " {name} ";
      sidebar-mode = true;
      matching = "prefix";
      scroll-method = 0;
      disable-history = false;
      show-icons = true;

      display-drun = "🚀 Run";
      display-run = "🚀 Run";
      display-filebrowser = "📂 Files";
      display-calc = "🧮 Calculator";
      display-emoji = "🤪 Emoji";
    };

    font = mkForce (with fonts; "${sansSerif.name} ${builtins.toString sizes.popups}");
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "window" = {
        transparency = "real";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        fullscreen = mkLiteral "false";
        width = mkLiteral "600px";
        x-offset = mkLiteral "0px";
        y-offset = mkLiteral "0px";
        enabled = mkLiteral "true";
        border-radius = mkLiteral "4px";
        border = mkLiteral "2px";
        border-color = mkLiteral "#${colors.base02}";
        cursor = "default";
      };

      "mainbox" = {
        enabled = true;
        spacing = mkLiteral "0px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = mkLiteral "[inputbar,listbox]";
      };

      "listbox" = {
        spacing = mkLiteral "10px";
        padding = mkLiteral "10px 10px 10px 10px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = mkLiteral "[message,listview]";
      };

      "inputbar" = {
        enabled = true;
        spacing = mkLiteral "10px";
        padding = mkLiteral "30px 20px 30px 20px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "horizontal";
        children = mkLiteral "[prompt,entry]";
      };

      "entry" = {
        enabled = true;
        expand = true;
        width = mkLiteral "300px";
        padding = mkLiteral "12px 15px";
        border-radius = mkLiteral "4px";
        background-color = mkLiteral "#${colors.base02}";
        cursor = mkLiteral "text";
        placeholder = "Search";
        placeholder-color = mkLiteral "inherit";
      };

      "prompt" = {
        width = mkLiteral "64px";
        padding = mkLiteral "10px 20px 10px 20px";
        border-radius = mkLiteral "4px";
        background-color = mkLiteral "#${colors.base02}";
        cursor = mkLiteral "pointer";
      };

      "mode-switcher" = {
        enabled = true;
        spacing = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
      };

      "button" = {
        width = mkLiteral "48px";
        padding = mkLiteral "8px 8px 8px 8px";
        border-radius = mkLiteral "4px";
        background-color = mkLiteral "@lightbg";
        cursor = mkLiteral "pointer";
      };

      "listview" = {
        enabled = true;
        columns = 2;
        lines = 7;
        cycle = true;
        dynamic = true;
        scrollbar = false;
        layout = mkLiteral "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = false;
        spacing = mkLiteral "5px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        cursor = mkLiteral "default";
      };

      "element" = {
        enabled = true;
        spacing = mkLiteral "15px";
        padding = mkLiteral "7px";
        border-radius = mkLiteral "4px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        cursor = mkLiteral "pointer";
      };

      "element-icon" = {
        size = mkLiteral "32px";
        cursor = mkLiteral "inherit";
        background-color = mkForce (mkLiteral "transparent");
      };

      "element normal.normal".background-color = mkForce (mkLiteral "transparent");
      "element alternate.normal".background-color = mkForce (mkLiteral "transparent");

      "element-text" = {
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
        background-color = mkForce (mkLiteral "transparent");
      };

      "message" = {background-color = mkLiteral "transparent";};

      "textbox" = {
        padding = mkLiteral "12px";
        border-radius = mkLiteral "4px";
        background-color = mkLiteral "@lightbg";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };

      "error-message" = {
        padding = mkLiteral "12px";
        border-radius = mkLiteral "4px";
        background-color = mkLiteral "@background";
        text-color = mkLiteral "@foreground";
      };
    };
  };
}
