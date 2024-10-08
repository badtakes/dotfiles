{inputs, ...}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
    inputs.base16.homeManagerModule

    ./misc
    ./packages
    ./programs
    ./services
    ./themes
  ];

  config = {
    home = {
      username = "marco";
      homeDirectory = "/home/marco";

      # This is, and should remain, the version on which you have initiated
      # the home-manager configuration. Similar to the `stateVersion` in the
      # NixOS module system, you should not be changing it.
      # I will personally strangle every moron who just puts nothing but "DONT CHANGE" next
      # to this value
      stateVersion = "24.05";
    };

    systemd.user.startServices = "sd-switch"; # "legacy" if "sd-switch" breaks again
  };
}
