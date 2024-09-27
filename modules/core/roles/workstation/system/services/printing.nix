{pkgs, ...}: {
  services = {
    printing = {
      enable = false;
      drivers = with pkgs; [
        gutenprint
        hplip
      ];
    };

    avahi = {
      enable = false;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
