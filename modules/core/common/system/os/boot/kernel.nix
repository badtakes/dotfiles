{
  pkgs,
  lib,
  ...
}: {
  config = {
    boot = {
      kernelPackages = pkgs.linuxPackages_cachyos-lto;
      kernelParams = [
        # Enable page allocator randomization
        "page_alloc.shuffle=1"

        # Reduce TTY output during boot
        # "quiet"

        # There is no reason to enable mitigations for most desktops.
        "mitigations=off"
      ];

      kernel.sysctl = lib.flattenAttrs' {
        kernel = {
          nmi_watchdog = 0;
          split_lock_mitigate = 0;
          sched_rt_runtime_us = -1;
        };
        fs.inotify.max_user_watches = 524288;
        net = {
          core.default_qdisc = "cake";
          ipv4 = {
            tcp_congestion_control = "bbr2";
            tcp_fastopen = 3;
            tcp_ecn = 1;
            tcp_timestamps = 0;
          };
        };
        vm = {
          dirty_background_ratio = 5;
          dirty_ratio = 10;
          page-cluster = 1;
          swappiness = 30;
          vfs_cache_pressure = 50;
        };
      };

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
    chaotic.scx.scheduler = "scx_rustland";
  };
}
