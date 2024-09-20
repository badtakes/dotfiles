{pkgs, ...}: {
  home.packages = with pkgs; [
    jetbrains.datagrip
    jetbrains.rider
    jetbrains.writerside
  ];
}
