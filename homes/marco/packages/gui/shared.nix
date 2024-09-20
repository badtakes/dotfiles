{pkgs, ...}: {
  home.packages = with pkgs; [
    qbittorrent
    helvum

    # Electron applications
    bitwarden-desktop
    signal-desktop

    # Obsidian has a pandoc plugin that allows us to render and export
    # alternative image format, but as the name indicates the plugin
    # requires `pandoc` binary to be accessiblee. Join pandoc derivation
    # to Obsidian to make it available to satisfy the dependency.
    (symlinkJoin {
      name = "Obsidian";
      paths = with pkgs; [
        obsidian
        pandoc
      ];
    })

    # plasma packages
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.ark
    kdePackages.kio
    kdePackages.kio-extras
    kdePackages.kimageformats
    kdePackages.kdegraphics-thumbnailers

    # Okular needs ghostscript to import PostScript files as PDFs
    # so we add ghostscript_headless as a dependency
    (symlinkJoin {
      name = "Okular";
      paths = with pkgs; [
        kdePackages.okular
        ghostscript_headless
      ];
    })

    # gnome packages
    gnome-tweaks
    gnome-calendar
  ];
}
