{config, ...}: {
  config.wayland.windowManager.sway.config.keybindings = let
    m = config.wayland.windowManager.sway.config.modifier;
  in {
    "${m}+Return" = "exec foot";
    "${m}+space" = "exec rofi -show drun";

    "${m}+q" = "kill";
    "${m}+t" = "floating toggle";

    "${m}+Shift+Left" = "move left";
    "${m}+Shift+Down" = "move down";
    "${m}+Shift+Up" = "move up";
    "${m}+Shift+Right" = "move right";

    "${m}+period" = "workspace next";
    "${m}+comma" = "workspace prev";

    "${m}+1" = "workspace number 1";
    "${m}+2" = "workspace number 2";
    "${m}+3" = "workspace number 3";
    "${m}+4" = "workspace number 4";
    "${m}+5" = "workspace number 5";
    "${m}+6" = "workspace number 6";
    "${m}+7" = "workspace number 7";
    "${m}+8" = "workspace number 8";
    "${m}+9" = "workspace number 9";

    "${m}+Shift+period" = "move container to workspace next; workspace next";
    "${m}+Shift+comma" = "move container to workspace prev; workspace prev";

    "${m}+tab" = "workspace next_on_output";
    "Alt+tab" = "workspace back_and_forth";

    "${m}+Shift+1" = "move container to workspace number 1";
    "${m}+Shift+2" = "move container to workspace number 2";
    "${m}+Shift+3" = "move container to workspace number 3";
    "${m}+Shift+4" = "move container to workspace number 4";
    "${m}+Shift+5" = "move container to workspace number 5";
    "${m}+Shift+6" = "move container to workspace number 6";
    "${m}+Shift+7" = "move container to workspace number 7";
    "${m}+Shift+8" = "move container to workspace number 8";
    "${m}+Shift+9" = "move container to workspace number 9";

    "${m}+Shift+c" = "reload";
    "${m}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

    "XF86MonBrightnessDown" = "exec light -U 10";
    "XF86MonBrightnessUp" = "exec light -A 10";

    "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1 @DEFAULT_SINK@ 5%+";
    "XF86AudioLowerVolume" = "exec wpctl set-volume -l 1 @DEFAULT_SINK@ 5%-";

    "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
    "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_SOURCE@ toggle";
  };
}
