{
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = false;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        output = [
          "eDP-1"
          "HDMI-A-1"
          "DP-1"
        ];

        spacing = 7;
        margin-left = 10;
        margin-top = 10;

        margin-right = 10;
        fixed-center = true;
        exclusive = true;

        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "wlr/taskbar"
        ];

        modules-center = [
          "privacy"
          "sway/window"
        ];

        modules-right = [
          "tray"
          "cpu"
          "backlight"
          "network"
          "bluetooth"
          "pulseaudio"
          "clock"
          "battery"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        backlight = let
          brightnessctl = lib.getExe pkgs.brightnessctl;
        in {
          format = " {icon} ";
          format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
          #format-icons = ["" "" "" "" "" "" "" "" ""];
          on-scroll-up = "${brightnessctl} s 1%-";
          on-scroll-down = "${brightnessctl} s +1%";
        };

        network = let
          nm-editor = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        in {
          format-wifi = " 󰤨 ";
          format-ethernet = " 󰈀 ";
          format-alt = " 󱛇 ";
          format-disconnected = " 󰤭 ";
          tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
          on-click-right = "${nm-editor}";
        };

        tray = {
          icon-size = 21;
          spacing = 10;
        };

        bluetooth = {
          # controller = "controller1", // specify the alias of the controller if there are more than 1 on the system
          format = "  ";
          format-disabled = " 󰂲 "; # an empty format will hide the module
          format-connected = " 󰂱 ";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-disabled = "";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        };

        pulseaudio = {
          scroll-step = 5;
          tooltip = true;
          tooltip-format = " {volume} ";
          on-click = "${pkgs.killall}/bin/killall pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
          format = "{icon}";
          format-muted = "󰝟";
          format-icons = {
            default = ["" "" ""];
          };
        };

        cpu = {
          interval = 10;
          format = "  ";
          max-length = 10;
          states = {
            "50" = 50;
            "60" = 75;
            "70" = 90;
          };
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = " {icon} ";
          format-charging = " 󰂄 ";
          format-plugged = " 󰂄 ";
          format-alt = " {icon} ";
          format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };

        clock = {
          format = " {:%H %M} ";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>
          '';
        };
      };
    };
  };

  programs.i3status-rust = {
    enable = false;
    bars = {
      bottom = {
        icons = "emoji";
        theme = "native";

        blocks = [
          {
            block = "memory";
            format = " $icon $mem_used_percents ";
            format_alt = " $icon $swap_used_percents ";
          }
          {
            block = "cpu";
            interval = 1;
            format = " $barchart $utilization $frequency ";
          }
          {
            block = "sound";
          }
          {
            block = "battery";
            device = "BAT0";
            format = " $icon $percentage $time $power ";
          }
          {
            block = "net";
            format = " $icon $ssid $signal_strength $ip ↓$speed_down ↑$speed_up ";
            interval = 2;
          }
          {
            block = "time";
            interval = 1;
            format = " $timestamp.datetime(f:'%F %T') ";
          }
        ];

        # blocks = [
        #   {
        #     block = "memory";
        #     format = " $icon $mem_used_percents ";
        #     format_alt = " $icon $swap_used_percents ";
        #   }
        #   {
        #     block = "cpu";
        #     interval = 1;
        #     format = " CPU $barchart $utilization ";
        #     format_alt = " CPU $frequency{ $boost|} ";
        #     merge_with_next = true;
        #   }
        #   {
        #     block = "load";
        #     format = " Avg $5m ";
        #     interval = 10;
        #     merge_with_next = true;
        #   }
        #   {
        #     block = "memory";
        #     format = " MEM $mem_used_percents ";
        #     format_alt = " MEM $swap_used_percents ";
        #   }
        #   {
        #     block = "battery";
        #     device = "BAT1";
        #     format = " $icon $percentage $time $power ";
        #   }
        #   {
        #     block = "net";
        #     format = " $icon $ssid $signal_strength $ip ↓$speed_down ↑$speed_up ";
        #     interval = 2;
        #   }
        #   {
        #     block = "time";
        #     interval = 1;
        #     format = " $timestamp.datetime(f:'%F %T') ";
        #   }
        #   {
        #     block = "sound";
        #   }
        # ];
      };
    };
  };
}
