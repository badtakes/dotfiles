{pkgs, ...}: {
  imports = [];
  config = {
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/1ec6ba14-3f75-40e2-a17c-c0be0e9a3077";
        fsType = "ext4";
      };

      "/boot" = {
        device = "/dev/disk/by-uuid/E6D9-03AC";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };
    };

    boot.initrd.luks.devices = {
      "luks-868ef724-769c-4080-bb76-ad44d86173da".device = "/dev/disk/by-uuid/868ef724-769c-4080-bb76-ad44d86173da";
      "luks-a0562e2f-ef43-4711-92a1-e38e05559f64".device = "/dev/disk/by-uuid/a0562e2f-ef43-4711-92a1-e38e05559f64";
    };

    swapDevices = [
      {device = "/dev/disk/by-uuid/507181c8-1cf5-48ef-b27c-8691c8e8624d";}
    ];

    hardware.nvidia.prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    user = {
      name = "marco";
      description = "Marco";

      packages = with pkgs; ([
          yt-dlp_git
          nushell
        ]
        ++ [
          # airwindows-lv2
          # ardour
          # artyFX
          # autotalent
          # bitwig-studio
          # calf
          # cardinal
          # carla
          # chow-centaur
          # chow-kick
          # chow-phaser
          # chow-tape-model
          # dexed
          # diopser
          # distrho
          # dragonfly-reverb
          # drumgizmo
          # drumkv1
          # eq10q
          # helm
          # lsp-plugins
          # odin2
          # renoise
          # sonic-pi
          # sorcer
          # soundfont-fluid
          # surge
          # tap-plugins
          # tunefish
          # vital
          # x42-avldrums
          # x42-gmsynth
          # x42-plugins
          # yabridge
          # yabridgectl
          # zam-plugins
          # zynaddsubfx
        ]);

      extraGroups = [
        "git"
        "input"
        "libvirtd"
        "lp"
        "mysql"
        "network"
        "networkmanager"
        "nix"
        "plugdev"
        "power"
        "systemd-journal"
        "tss"
        "video"
        "wheel"
        "wireshark"
      ];
    };

    modules = {
      audio = {
        enable = true;
        realtime = true;
      };

      bluetooth.enable = true;

      windowManager.gnome.enable = true;
      windowManager.sway.enable = false;
    };

    musnix = {
      enable = true;
      alsaSeq.enable = true;
      rtcqs.enable = true;
      soundcardPciId = "00:1f.3";

      kernel.realtime = true;
      rtirq.enable = true;
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?
  };
}
