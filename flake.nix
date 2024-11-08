{
  description = "Personal NixOS configuration";

  inputs = {
    systems.url = "github:nix-systems/default-linux";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nixpkgs-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs-small";
      inputs.home-manager.follows = "home-manager";
    };

    nix-index-db = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-small";
    };

    # nixvim.url = "github:nix-community/nixvim/main";
    # nixvim.inputs.nixpkgs.follows = "nixpkgs";

    base16.url = "github:SenchoPens/base16.nix";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
        ./packages
      ];
    };
}
