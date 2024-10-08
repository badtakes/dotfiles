{...}: {
  programs.i3status-rust = {
    enable = true;
    bars = {
      bottom = {
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
            format = " CPU $barchart $utilization ";
            format_alt = " CPU $frequency{ $boost|} ";
            merge_with_next = true;
          }
          {
            block = "load";
            format = " Avg $5m ";
            interval = 10;
            merge_with_next = true;
          }
          {
            block = "memory";
            format = " MEM $mem_used_percents ";
            format_alt = " MEM $swap_used_percents ";
          }
          {
            block = "battery";
            device = "BAT1";
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
          {
            block = "sound";
          }
        ];
      };
    };
  };
}
