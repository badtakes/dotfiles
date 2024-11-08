{...}: {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
      gtk-enable-primary-paste = false;
    };

    # tell virt-manager to use the system connection
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
