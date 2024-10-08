{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.lib.stylix) colors;
in {
  config = {
    home.packages = with pkgs; [
      libsixel
    ];

    programs.foot = {
      enable = true;
      server.enable = false;
      settings = {
        main = {
          app-id = "foot";
          title = "foot";
          locked-title = "no";
          term = "xterm-256color";
          pad = "16x16 center";
          shell = "zsh";

          # desktop-notifications.command = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
          selection-target = "clipboard";

          # dpi-aware = false;
          # font = "Iosevka Nerd Font:size=14";
          # font-bold = "Iosevka Nerd Font:size=14";
          vertical-letter-offset = "-0.90";
        };

        scrollback = {
          lines = 10000;
          multiplier = 3;
        };

        tweak = {
          font-monospace-warn = "no";
          sixel = "yes";
        };

        cursor = {
          style = "beam";
          beam-thickness = 2;
        };

        mouse = {
          hide-when-typing = "yes";
        };

        url = {
          launch = "xdg-open \${url}";
          label-letters = "sadfjklewcmpgh";
          osc8-underline = "url-mode";
          protocols = "http, https, ftp, ftps, file";
          uri-characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+=\"'()[]";
        };

        colors = with colors; {
          foreground = base05;
          background = base00;

          regular0 = base01;
          regular1 = base08;
          regular2 = base0B;
          regular3 = base0A;
          regular4 = base0D;
          regular5 = base0E;
          regular6 = base0C;
          regular7 = base05;

          bright0 = base03;
          bright1 = base08;
          bright2 = base0B;
          bright3 = base0A;
          bright4 = base0D;
          bright5 = base0E;
          bright6 = base0C;
          bright7 = base05;
        };
      };
    };
  };
}
