{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.easyOverlay];
  perSystem = {
    config,
    pkgs,
    lib,
    ...
  }: let
    dbus-sway-environment = pkgs.writeTextFile {
      name = "dbus-sway-environment";
      destination = "/bin/dbus-sway-environment";
      executable = true;
      text = ''
        dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP=sway
        systemctl --user stop pipewire xdg-desktop-portal xdg-desktop-portal-wlr
        systemctl --user start pipewire xdg-desktop-portal xdg-desktop-portal-wlr
      '';
    };

    configure-gtk = let
      gsettings = lib.getExe' pkgs.glib "gsettings";
    in
      pkgs.writeTextFile {
        name = "configure-gtk";
        destination = "/bin/configure-gtk";
        executable = true;
        text = ''
          CONFIG_FILE="$XDG_CONFIG_HOME/gtk-3.0/settings.ini"

          if [ ! -f "$CONFIG_FILE" ]; then
            exit 1;
          fi

          GTK_THEME="$(grep 'gtk-theme-name' "$CONFIG_FILE" | sed 's/.*\s*=\s*//')"
          ICON_THEME="$(grep 'gtk-icon-theme-name' "$CONFIG_FILE" | sed 's/.*\s*=\s*//')"
          CURSOR_THEME="$(grep 'gtk-cursor-theme-name' "$CONFIG_FILE" | sed 's/.*\s*=\s*//')"
          FONT_NAME="$(grep 'gtk-font-name' "$CONFIG_FILE" | sed 's/.*\s*=\s*//')"
          # COLOR_SCHEME="$(grep)";

          ${gsettings} set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
          ${gsettings} set org.gnome.desktop.interface icon-theme "$ICON_THEME"
          ${gsettings} set org.gnome.desktop.interface cursor-theme "$CURSOR_THEME"
          ${gsettings} set org.gnome.desktop.interface font-name "$FONT_NAME"

          ${gsettings} set org.gnome.desktop.interface color-scheme prefer-dark
        '';
      };
  in {
    overlayAttrs = config.packages;
    packages = {
      inherit configure-gtk dbus-sway-environment;
    };
  };
}
