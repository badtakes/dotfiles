{...}: {
  boot = {
    initrd.availableKernelModules = [
      "aesni_intel"
      "ahci"
      "cryptd"
      "nvme"
      "sd_mod"
      "usb_storage"
      "xhci_pci"
    ];

    kernelParams = [
      "luks.options=timeout=0"
      "rd.luks.options=timeout=0"
    ];
  };
}
