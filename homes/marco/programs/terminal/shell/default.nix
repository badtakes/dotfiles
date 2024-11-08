{...}: {
  imports = [
    ./zsh

    ./starship.nix
    ./bash.nix
  ];

  config = {
    programs.carapace.enable = true;
  };
}
