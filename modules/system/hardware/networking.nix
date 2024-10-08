{
  pkgs,
  lib,
  ...
}: {
  config = {
    environment.systemPackages = with pkgs; [
      mtr
      tcpdump
      traceroute
    ];

    networking = {
      networkmanager.enable = true;
      useDHCP = lib.mkDefault true;

      nameservers = [
        # Cloudflare
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"

        # Quad9
        "9.9.9.9"
        "149.112.112.112"
        "2620:fe::fe"
        "2620:fe::9"
      ];

      stevenblack = {
        enable = true;
        block = ["fakenews" "gambling"];
      };
    };
  };
}
