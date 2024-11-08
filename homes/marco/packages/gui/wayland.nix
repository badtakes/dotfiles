{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      wlogout
      wdisplays
      swayimg
      swappy
    ];
  };
}
