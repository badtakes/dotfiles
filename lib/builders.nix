{
  inputs,
  lib,
  ...
}: let
  inherit (inputs) self nixpkgs;

  inherit (lib) mkDefault;
  inherit (lib.lists) singleton concatLists;
  inherit (lib.attrsets) recursiveUpdate;

  modulesPath = "${nixpkgs}/nixos/modules";

  mkNixosSystem = {
    withSystem,
    system,
    hostName,
    ...
  } @ args:
    withSystem system ({
      inputs',
      self',
      ...
    }:
      lib.nixosSystem {
        specialArgs = recursiveUpdate {
          inherit (self) keys;
          inherit lib modulesPath;
          inherit inputs self inputs' self';
        } (args.specialArgs or {});

        modules = concatLists [
          (singleton {
            networking.hostName = hostName;
            nixpkgs = {
              hostPlatform = mkDefault system;
              flake.source = nixpkgs.outPath;
            };
          })

          (args.modules or [])
        ];
      });
in {
  inherit mkNixosSystem;
}
