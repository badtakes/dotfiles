{pkgs, ...}: {
  services.dbus = {
    enable = true;
    packages = with pkgs; [dconf gcr udisks2 gnome2.GConf];

    # Use the faster dbus-broker instead of the classic dbus-daemon
    implementation = "broker";
  };
}
