{
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault mkForce;
in {
  config.boot = {
    # kernel console loglevel
    consoleLogLevel = 3;

    # # always use the latest kernel instead of the old-ass lts one
    # kernelPackages = mkOverride 500 sys.boot.kernel;

    # # additional packages supplying kernel modules
    # extraModulePackages = mkDefault sys.boot.extraModulePackages;

    # # configuration to be appended to the generated modprobe.conf
    # extraModprobeConfig = mkDefault sys.boot.extraModprobeConfig;

    # whether to enable support for Linux MD RAID arrays
    # I don't know why this defaults to true, how many people use RAID anyway?
    # also on > 23.11, this will throw a warning if neither MAILADDR nor PROGRAM are set
    swraid.enable = mkDefault false;

    # settings shared between bootloaders
    # they are set unless system.boot.loader != none
    loader = {
      # if set to 0, space needs to be held to get the boot menu to appear
      timeout = mkForce 2;

      # whether to copy the necessary boot files into /boot
      # so that /nix/store is not needed by the boot loader.
      generationsDir.copyKernels = true;

      # allow installation to modify EFI variables
      efi.canTouchEfiVariables = true;
    };

    # instructions on how /tmp should be handled
    # if your system is low on ram, you should avoid tmpfs to prevent hangups while compiling
    tmp = {
      # /tmp on tmpfs, lets it live on your ram
      # it defaults to FALSE, which means you will use disk space instead of ram
      # enable tmpfs tmp on anything except servers and builders
      useTmpfs = true;

      # If not using tmpfs, which is naturally purged on reboot, we must clean
      # /tmp ourselves. /tmp should be volatile storage!
      cleanOnBoot = mkDefault (!config.boot.tmp.useTmpfs);

      # The size of the tmpfs, in percentage form
      # this defaults to 50% of your ram, which is a good default
      # but should be tweaked based on your systems capabilities
      tmpfsSize = mkDefault "75%";
    };

    # https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
    kernelParams = [
      # https://en.wikipedia.org/wiki/Kernel_page-table_isolation
      # auto means kernel will automatically decide the pti state
      "pti=auto" # on | off

      # CPU idle behaviour
      #  poll: slightly improve performance at cost of a hotter system (not recommended)
      #  halt: halt is forced to be used for CPU idle
      #  nomwait: Disable mwait for CPU C-states
      "idle=nomwait" # poll | halt | nomwait

      # enable IOMMU for devices used in passthrough
      # and provide better host performance in virtualization
      "iommu=pt"

      # disable usb autosuspend
      "usbcore.autosuspend=-1"

      # disables resume and restores original swap space
      "noresume"

      # allows systemd to set and save the backlight state
      "acpi_backlight=native" # none | vendor | video | native

      # prevent the kernel from blanking plymouth out of the fb
      "fbcon=nodefer"

      # disable the cursor in vt to get a black screen during intermissions
      "vt.global_cursor_default=0"

      # disable displaying of the built-in Linux logo
      "logo.nologo"
    ];

    # ++ (optionals sys.boot.silentBoot [
    #   # tell the kernel to not be verbose
    #   "quiet"

    #   # kernel log message level
    #   "loglevel=3" # 1: sustem is unusable | 3: error condition | 7: very verbose

    #   # udev log message level
    #   "udev.log_level=3"

    #   # lower the udev log level to show only errors or worse
    #   "rd.udev.log_level=3"

    #   # disable systemd status messages
    #   # rd prefix means systemd-udev will be used instead of initrd
    #   "systemd.show_status=auto"
    #   "rd.systemd.show_status=auto"
    # ])
  };
}
