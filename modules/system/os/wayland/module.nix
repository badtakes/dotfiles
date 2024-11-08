{pkgs, ...}: {
  imports = [
    ./window-managers

    ./xdg-portals.nix
  ];

  config = {
    programs.xwayland.enable = true;
    programs.wshowkeys.enable = true;

    chaotic.appmenu-gtk3-module.enable = true;

    environment.systemPackages = with pkgs; [
      libnotify
      xdg-utils
      sox
    ];

    environment.variables = {
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      NIXOS_OZONE_WL = "1";
      GDK_BACKEND = "wayland,x11";
      ANKI_WAYLAND = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
    };
  };
}
