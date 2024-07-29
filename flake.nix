{
  description = "Personal NixOS configuration";

  inputs = {
    systems.url = "github:nix-systems/default-linux";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:NixOS/nixpkgs/nixos-unstable-small"; # moves faster, has less packages

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim/main";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    apple-fonts.url = "github:ostmarco/apple-fonts.nix";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;

      imports = [
        ({inputs, ...}: {
          perSystem = {
            config,
            system,
            ...
          }: {
            legacyPackages = import inputs.nixpkgs {
              inherit system;

              config = {
                allowUnfree = true;
                allowUnsupportedSystem = true;
              };

              overlays = [inputs.self.overlays.default];
            };

            _module.args = {
              pkgs = config.legacyPackages;
            };
          };
        })

        ./lib
        ./hosts
      ];
    };
}
