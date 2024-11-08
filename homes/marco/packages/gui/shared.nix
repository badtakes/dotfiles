{pkgs, ...}: {
  home.packages = with pkgs; [
    helvum
    qbittorrent

    # Electron applications
    bitwarden-desktop
    signal-desktop
    slack

    code-cursor

    stremio

    anytype

    # plasma packages
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.ark
    kdePackages.kio
    kdePackages.kio-extras
    kdePackages.kimageformats
    kdePackages.kdegraphics-thumbnailers

    # gnome packages
    gnome-calculator
    gnome-calendar
    gnome-feeds
    gnome-logs
    gnome-tweaks
  ];
}
