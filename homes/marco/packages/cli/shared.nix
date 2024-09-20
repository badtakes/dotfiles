{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
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
