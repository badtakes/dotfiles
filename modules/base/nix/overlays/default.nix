{
  config,
  lib,
  ...
}: let
  inherit (lib.trivial) const;

  nix = config.nix.package;
in {
  nixpkgs.overlays = [
    (const (prev: {
      nixos-rebuild = prev.nixos-rebuild.override {inherit nix;};
      nix-direnv = prev.nix-direnv.override {inherit nix;};
      nix-index = prev.nix-index.override {inherit nix;};

      # rofi-calc = prev.rofi-calc.override {rofi-unwrapped = prev.rofi-wayland-unwrapped;};
    }))
  ];
}
