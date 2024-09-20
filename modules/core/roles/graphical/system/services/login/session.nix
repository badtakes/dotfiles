_: {
  # adding desktop items to the environment is generally handled by the programs' respective
  # nixos modules, however, to unify the desktop interface I prefer handling them manually
  # and ignoring the nixos modules entirely.
  services.xserver.displayManager = {
    startx.enable = true;
  };
}
