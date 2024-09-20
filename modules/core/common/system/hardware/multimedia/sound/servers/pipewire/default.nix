{...}: {
  services.pipewire = {
    enable = true;

    audio.enable = true;

    pulse.enable = true;
    jack.enable = true;
    alsa = {
      enable = true;
      enable32Bit = true;
    };
  };
}
