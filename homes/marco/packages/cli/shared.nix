{
  inputs',
  pkgs,
  ...
}: {
  config = {
    home.packages = with pkgs; [
      inputs'.agenix.packages.default

      catimg
      duf
      todo
      hyperfine
      fzf
      file
      unzip
      ripgrep
      rsync
      fd
      jq
      figlet
      dconf
      nitch
      skim
      p7zip
      btop
    ];
  };
}
