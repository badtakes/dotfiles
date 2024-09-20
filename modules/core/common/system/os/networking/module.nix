{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkDefault mkForce;
in {
  imports = [
    ./blocker.nix
    ./network-manager.nix
  ];

  boot.kernelModules = ["af_packet"];
  environment.systemPackages = with pkgs; [
    mtr
    tcpdump
    traceroute
  ];

  networking = {
    useDHCP = mkForce false;
    useNetworkd = mkForce true;

    usePredictableInterfaceNames = mkDefault true;

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
  };

  hardware.wirelessRegulatoryDatabase = true;
}
