{
  osConfig,
  lib,
  ...
}: {
  home.pointerCursor = {
    # Package, name and the size of the cursor. The same values need to be set
    # in Hyprland config to make sure our cursors are consistent.
    package = lib.mkDefault osConfig.stylix.cursor.package;
    name = lib.mkDefault osConfig.stylix.cursor.name;
    size = lib.mkDefault osConfig.stylix.cursor.size;

    # Enable GTK config generation for pointerCursor
    gtk.enable = true;

    # Enable X11 config generation for pointerCursor
    x11.enable = true;
  };
}
