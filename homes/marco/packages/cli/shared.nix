{
  inputs',
  pkgs,
  ...
}: {
  config = {
    home.packages = with pkgs; [
      inputs'.agenix.packages.default

      croc
      wush

      bitwarden-cli
      btop
      catimg
      dconf
      duf
      fd
      figlet
      file
      fzf
      hyperfine
      jq
      nitch
      p7zip
      presenterm
      ripgrep
      rsync
      skim
      todo
      unzip
    ];
  };
}
