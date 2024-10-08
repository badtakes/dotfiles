{pkgs, ...}: {
  config = {
    services.flameshot.enable = true;
    services.flameshot.package = pkgs.flameshot.override {enableWlrSupport = true;};
  };
}
