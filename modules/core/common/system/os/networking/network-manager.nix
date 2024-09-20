{pkgs, ...}: {
  environment.systemPackages = [pkgs.networkmanagerapplet];

  networking = {
    networkmanager.enable = true;
    enableIPv6 = true;
  };
}
