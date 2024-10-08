{pkgs, ...}: {
  home.packages = with pkgs; [
    jetbrains.datagrip
    jetbrains.idea-ultimate
    jetbrains.rider
    jetbrains.writerside
  ];
}
