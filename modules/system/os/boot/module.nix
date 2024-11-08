{
  lib,
  pkgs,
  ...
}: {
  config = {
    boot = {
      tmp.cleanOnBoot = true;

      loader = {
        efi.canTouchEfiVariables = true;
        generationsDir.copyKernels = true;

        systemd-boot = {
          enable = true;
          editor = false;
          configurationLimit = 5;
        };
      };

      kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos-rc;
      kernelParams = [
        # Enable page allocator randomization
        "page_alloc.shuffle=1"

        # Reduce TTY output during boot
        "quiet"
        "splash"

        # There is no reason to enable mitigations for most desktops.
        "mitigations=off"

        # Disable luks password prompt timeout
        "luks.options=timeout=0"
        "rd.luks.options=timeout=0"

        # My laptop has a power button
        "nowatchdog"
      ];

      kernel.sysctl = lib.flattenAttrs' {
        kernel = {
          nmi_watchdog = 0;
          split_lock_mitigate = 0;
        };
        fs.inotify.max_user_watches = 524288;
        net = {
          core = {
            default_qdisc = "cake";
            netdev_max_backlog = 16384;
          };
          ipv4 = {
            tcp_congestion_control = "bbr2";
            tcp_fastopen = 3;
            tcp_timestamps = 0;
          };
        };
        vm.vfs_cache_pressure = 50;
      };

      initrd.availableKernelModules = [
        "aesni_intel"
        "ahci"
        "cryptd"
        "nvme"
        "sd_mod"
        "usb_storage"
        "xhci_pci"
      ];

      blacklistedKernelModules = [
        # Bad Realtek driver
        "r8188eu"

        # obscure network protocols
        "ax25"
        "netrom"
        "rose"

        # Old or rare or insufficiently audited filesystems
        "adfs"
        "affs"
        "bfs"
        "befs"
        "cramfs"
        "efs"
        "erofs"
        "exofs"
        "freevxfs"
        "f2f2"
        "hfs"
        "hpfs"
        "jfs"
        "minix"
        "nilfs2"
        "ntfs"
        "omfs"
        "qnx4"
        "qnx6"
        "sysv"
        "ufs"
      ];
    };

    # https://github.com/sched-ext/scx/tree/main/scheds/rust/scx_rustland
    chaotic.scx.enable = true;
    chaotic.scx.scheduler = "scx_bpfland";
  };
}
