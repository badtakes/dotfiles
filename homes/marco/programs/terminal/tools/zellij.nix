{...}: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      # default_layout = "compact";
      copy_command = "wl-copy";
    };
  };
}
