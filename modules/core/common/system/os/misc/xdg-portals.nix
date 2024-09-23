{...}: {
  xdg.portal.config = {
    common = {
      default = ["gtk"];

      "org.freedesktop.impl.portal.Secret" = [
        "gnome-keyring"
      ];
    };
  };
}
