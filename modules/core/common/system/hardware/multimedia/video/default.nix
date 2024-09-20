{pkgs, ...}: {
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  environment.systemPackages = with pkgs; [
    glxinfo
    glmark2
  ];
}
