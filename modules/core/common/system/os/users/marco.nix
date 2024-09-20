{pkgs, ...}: {
  users.users.marco = {
    isNormalUser = true;

    createHome = true;
    home = "/home/marco";

    shell = pkgs.zsh;

    extraGroups = [
      "wheel"
      "systemd-journal"
      "audio"
      "video"
      "input"
      "plugdev"
      "lp"
      "tss"
      "power"
      "nix"
      "network"
      "networkmanager"
      "wireshark"
      "mysql"
      "docker"
      "podman"
      "git"
      "libvirtd"
    ];
  };
}
