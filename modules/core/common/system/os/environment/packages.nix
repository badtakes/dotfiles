{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    curl
    wget
    rsync
    lshw
    pciutils
    dnsutils
  ];
}
