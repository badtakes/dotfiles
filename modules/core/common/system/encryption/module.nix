{...}: {
  boot = {
    initrd.availableKernelModules = [
      "aesni_intel"
      "cryptd"
      "usb_storage"
    ];

    kernelParams = [
      # Disable password timeout
      "luks.options=timeout=0"
      "rd.luks.options=timeout=0"

      # Assume root device is already there, do not wait or it to appear.
      "rootflags=x-systemd.device-timeout=0"
    ];
  };
}
