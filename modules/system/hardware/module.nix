{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./graphics.nix
    ./intel.nix
    ./nvidia.nix
    ./power.nix
    ./touchpad.nix
  ];

  config = {
    hardware.enableRedistributableFirmware = true;
  };
}
