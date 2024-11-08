{
  imports = [
    # ./bin
    ./git

    ./bat.nix
    ./bottom.nix
    ./dircolors.nix
    ./editorconfig.nix
    ./eza.nix
    ./fastfetch.nix
    ./nix-direnv.nix
    ./nix-index.nix
    ./ripgrep.nix
    ./zellij.nix
    ./zoxide.nix
  ];

  config = {
    programs.aria2.enable = true;
    programs.gh-dash.enable = true;
    programs.git-credential-oauth.enable = true;
    programs.hyfetch.enable = true;

    programs.navi.enable = true;
  };
}
