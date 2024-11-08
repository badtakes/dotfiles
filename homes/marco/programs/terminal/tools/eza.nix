{
  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
    enableZshIntegration = false;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
}
