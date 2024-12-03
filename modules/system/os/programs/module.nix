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
      dnsutils
      lshw
      openssl
      pciutils
      rsync
      wget
    ];
  };
}
