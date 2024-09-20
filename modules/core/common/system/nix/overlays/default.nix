{
  config,
  lib,
  ...
}: let
  inherit (lib.trivial) const;

  systemNix = config.nix.package;
in {
  # Overlays are by far the most obscure and annoying feature of Nix. This is a last resort
  # and should be used conservatively. If possible, use override or `overrideAttrs` whenever
  # you are able to.
  nixpkgs.overlays = [
    # Some packages provide their own instances of Nix by adding `nix` to the argset
    # of a derivation. While in most cases a simple `.override` will allow you to easily
    # replace their instance of Nix, you might want to do it across the dependency tree
    # in certain cases. For example if the package you are overriding is a dependency to
    # or is called by other packages.

    (const (prev: {
      nixos-rebuild = prev.nixos-rebuild.override {
        nix = systemNix;
      };

      nix-direnv = prev.nix-direnv.override {
        nix = systemNix;
      };

      nix-index = prev.nix-index.override {
        nix = systemNix;
      };
    }))
  ];
}
