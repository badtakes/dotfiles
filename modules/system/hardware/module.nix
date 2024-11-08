{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./graphics.nix
    ./intel.nix
    ./nvidia.nix
    ./networking.nix
    ./power.nix
    ./touchpad.nix
  ];

  config = {
    hardware.enableRedistributableFirmware = true;
  };
}
