{
  config,
  pkgs,
  ...
}: {
  config = {
    xdg.systemDirs.data = let
      schema = pkgs.gsettings-desktop-schemas;
    in ["${schema}/share/gsettings-schemas/${schema.name}"];

    home = {
      packages = [pkgs.glib]; # gsettings
    };

    gtk = {
      enable = true;

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme.override {withElementary = true;};
      };

      gtk2 = {
        configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
        extraConfig = ''
          gtk-xft-antialias=1
          gtk-xft-hinting=1
          gtk-xft-hintstyle="hintslight"
          gtk-xft-rgba="rgb"
        '';
      };

      gtk3.extraConfig = {
        # Decorations
        gtk-decoration-layout = "appmenu:none";
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-button-images = 1;
        gtk-menu-images = 1;

        # Silence bells and whistles, quite literally.
        gtk-error-bell = 0;
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;

        # Fonts
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
      };

      gtk4.extraConfig = {
        # Decorations.
        gtk-decoration-layout = "appmenu:none";

        # Sounds, again.
        gtk-error-bell = 0;
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;

        # Fonts, you know the drill.
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
      };
    };

    xdg.configFile = let
      css = config.xdg.configFile."gtk-4.0/gtk.css".text;
    in {
      "gtk-3.0/gtk-dark.css".text = css;
      "gtk-4.0/gtk-dark.css".text = css;
    };

    # # Store GTK css theme in a more easily discoverable location that some
    # # applications *might* be smart enough to look at: ~/.config/gtk-4.0
    # xdg.configFile = let
    #   package = pkgs.catppuccin-gtk.override {
    #     variant = "mocha";
    #     size = "standard";
    #     accents = ["blue"];
    #     tweaks = ["normal"];
    #   };
    #   gtk4Dir = "${package}/share/themes/catppuccin-mocha-blue-standard+normal/gtk-4.0";
    # in {
    #   "gtk-4.0/assets".source = "${gtk4Dir}/assets";
    #   "gtk-4.0/gtk.css".source = "${gtk4Dir}/gtk.css";
    #   "gtk-4.0/gtk-dark.css".source = "${gtk4Dir}/gtk-dark.css";
    # };
  };
}
