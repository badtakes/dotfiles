{pkgs, ...}: {
  imports = [
    ./marco.nix
    ./root.nix
  ];

  config = {
    users = {
      defaultUserShell = pkgs.zsh;

      allowNoPasswordLogin = false;
      enforceIdUniqueness = true;
    };
  };
}
