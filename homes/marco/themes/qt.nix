{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkMerge;
in {
  config = {
    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    home = {
      packages = with pkgs;
        mkMerge [
          [
            # Libraries and programs to ensure
            # that QT applications load without issues, e.g. missing libs.
            libsForQt5.qt5.qtwayland # qt5
            kdePackages.qtwayland # qt6
            qt6.qtwayland
            kdePackages.qqc2-desktop-style

            # qt5ct/qt6ct for configuring QT apps imperatively
            # libsForQt5.qt5ct
            # kdePackages.qt6ct

            # Some KDE applications such as Dolphin try to fall back to Breeze
            # theme icons. Lets make sure they're also found.
            # libsForQt5.breeze-qt5
            # kdePackages.breeze-icons
            # qt6.qtsvg # needed to load breeze icons
          ]

          [
            # Libraries to ensure that "gtk" platform theme works
            # as intended after the following PR:
            # <https://github.com/nix-community/home-manager/pull/5156>
            libsForQt5.qtstyleplugins
            qt6Packages.qt6gtk2
          ]

          [
            # Kvantum as a library and a program to theme qt applications
            # is added here, however, this will not have an effect
            # until QT_QPA_PLATFORMTHEME has been set appropriately
            # we still write the config files for Kvantum below
            # but again, it is a no-op until the env var is set
            libsForQt5.qtstyleplugin-kvantum
            qt6Packages.qtstyleplugin-kvantum
          ]
        ];

      sessionVariables = {
        # Scaling factor for QT applications. 1 means no scaling
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";

        # Use Wayland as the default backend, fallback to XCB if Wayland is not available
        QT_QPA_PLATFORM = "wayland;xcb";

        # Disable QT specific window decorations everywhere
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

        # Do remain backwards compatible with QT5 if possible.
        DISABLE_QT5_COMPAT = "0";
      };
    };
  };
}
