{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      alejandra
      devenv
      gh
      nil
      nixd
      zx
    ];
  };
}
