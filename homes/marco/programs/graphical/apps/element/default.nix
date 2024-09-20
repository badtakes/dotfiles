{pkgs, ...}: {
  config = {
    home.packages = [pkgs.element-desktop];
    xdg.configFile = {
      "Element/config.json".text = builtins.toJSON {
        default_server_config = {
          "m.homeserver" = {
            base_url = "";
            server_name = "";
          };
          "m.identity_server" = {base_url = "";};
        };
        show_labs_settings = true;
        default_theme = "dark";
      };
    };
  };
}
