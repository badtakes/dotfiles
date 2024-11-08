{pkgs, ...}: {
  programs.dconf.enable = true;

  services = {
    sysprof.enable = true;

    udev.packages = [pkgs.gnome-settings-daemon];

    gnome = {
      gnome-keyring.enable = true;
    };
  };
}
