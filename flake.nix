{
  description = "Personal NixOS configuration";

  inputs = {
    systems.url = "github:nix-systems/default-linux";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-db = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    # nyxexprs = {
    #   url = "github:NotAShelf/nyxexprs";
    #   inputs.systems.follows = "systems";
    # };

    spicetify = {
      url = "github:gerg-l/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    # nixvim.url = "github:nix-community/nixvim/main";
    # nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # stylix.url = "github:danth/stylix";
    # stylix.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland & Hyprland Contrib repos
    # to be able to use the binary cache, we should avoid
    # overriding the nixpkgs input - as the resulting hash would
    # mismatch if packages are built against different versions
    # of the same depended packages.
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    hyprpicker.url = "github:hyprwm/hyprpicker";

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland-hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };
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
            # Configure nixpkgs locally and expose it as <flakeRef>.legacyPackages.
            # This will then be consumed to override flake-parts' pkgs argument
            # to make sure pkgs instances in flake-parts modules are all referring
            # to the same configuration instance - this one.
            legacyPackages = import inputs.nixpkgs {
              inherit system;

              config = {
                allowUnfree = true;
                allowUnsupportedSystem = true;
              };

              # overlays = [inputs.self.overlays.default];
            };

            _module.args = {
              # Unify all instances of nixpkgs into a single `pkgs` set
              # Wthat includes our own overlays within `perSystem`. This
              # is not done by flake-parts, so we do it ourselves.
              # See:
              #  <https://github.com/hercules-ci/flake-parts/issues/106#issuecomment-1399041045>
              pkgs = config.legacyPackages;
            };
          };
        })

        ./lib
        ./hosts
      ];
    };
}
