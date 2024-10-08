{...}: {
  time = {
    timeZone = "America/Sao_Paulo";
    hardwareClockInLocalTime = false;
  };

  networking.timeServers = [
    "time.google.com"
    "time1.google.com"
    "time2.google.com"
    "time3.google.com"
    "time4.google.com"
  ];

  services.openntpd = {
    enable = true;
    extraConfig = ''
      listen on 127.0.0.1
      listen on ::1
    '';
  };
}
