{pkgs, ...}: {
  programs.zsh.plugins = [
    {
      name = "fzf-tab";
      file = "fzf-tab.plugin.zsh";
      src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
    }
    {
      name = "nix-shell";
      file = "nix-shell.plugin.zsh";
      src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
    }
    {
      name = "fast-syntax-highlighting";
      file = "fast-syntax-highlighting.plugin.zsh";
      src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
    }
    {
      name = "zsh-history-substring-search";
      file = "zsh-history-substring-search.zsh";
      src = "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search";
    }
    {
      name = "zsh-autosuggestions";
      file = "zsh-autosuggestions.zsh";
      src = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
    }
    {
      name = "zsh-autopair";
      file = "autopair.zsh";
      src = "${pkgs.zsh-autopair}/share/zsh/zsh-autopair";
    }
    {
      name = "zsh-powerlevel10k";
      file = "powerlevel10k.zsh-theme";
      src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
    }
  ];
}
