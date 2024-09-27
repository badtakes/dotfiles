{...}: {
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
  };
}
