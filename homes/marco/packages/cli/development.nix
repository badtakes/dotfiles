{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      devenv
      gh
      zx
    ];
  };
}
