{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.meta) getExe getExe';
  inherit (pkgs) eza bat ripgrep dust procs yt-dlp;

  dig = getExe' pkgs.dnsutils "dig";
in {
  programs.zsh.shellAliases = {
    sudo = "sudo ";

    nix-bloat = "nix path-info -Sh /run/current-system";
    nix-cleanup = "sudo nix-collect-garbage --delete-older-than 3d && nix-collect-garbage -d";
    nix-repair = "nix-store --verify --check-contents --repair";
    search = "nix search";
    shell = "nix-shell";

    cat = "${getExe bat} --style-plain";
    grep = "${getExe ripgrep}";

    l = "ls -lF --time-style=long-iso --icons";
    la = "${getExe eza} -lah --tree";
    ls = "${getExe eza} -h --git --icons --color=auto --group-directories-first -s extension";
    tree = "${getExe eza} --tree --icons=always";

    du = "${getExe dust}";
    ps = "${getExe procs}";
    burn = "pkill -9";
    diff = "diff --color=auto";
    cpu = ''watch -n.1 "grep \"^[c]pu MHz\" /proc/cpuinfo"'';
    killall = "pkill";

    myip = "${dig} @resolver4.opendns.com myip.opendns.com +short";
    myipv4 = "${dig} @resolver4.opendns.com myip.opendns.com +short -4";
    myipv6 = "${dig} @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6";

    ytmp3 = ''
      ${getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"
    '';

    ".." = "cd ..";
    "..." = "cd ../../";
    "...." = "cd ../../../";
    "....." = "cd ../../../../";
    "......" = "cd ../../../../../";
  };
}
