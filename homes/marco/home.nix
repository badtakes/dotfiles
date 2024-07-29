{
  config = {
    home = {
      username = "marco";
      homeDirectory = "/home/marco";

      stateVersion = "23.11";
    };

    systemd.user.startServices = "sd-switch"; # "legacy" if "sd-switch" breaks again
  };
}
