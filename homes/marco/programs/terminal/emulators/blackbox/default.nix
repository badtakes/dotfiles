{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      blackbox-terminal
    ];
  };
}
