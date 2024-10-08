{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./direnv.nix
    ./nano.nix
    ./zsh.nix
  ];
  config = {
    programs = {
      less.enable = true;
      git.enable = true;
    };

    environment.systemPackages = with pkgs; [
      curl
      wget
      rsync
      lshw
      pciutils
      dnsutils
    ];
  };
}
