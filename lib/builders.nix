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

  mkSystem = lib.nixosSystem;

  mkNixosSystem = {
    withSystem,
    system,
    hostName,
    modules ? [],
    specialArgs ? {},
    ...
  } @ args:
    withSystem system ({
      inputs',
      self',
      ...
    }:
      mkSystem ({
          modules = concatLists [
            (singleton {
              networking.hostName = hostName;
              nixpkgs = {
                hostPlatform = mkDefault system;
                flake.source = nixpkgs.outPath;
              };
            })

            modules
          ];

          specialArgs =
            recursiveUpdate {
              inherit (self) keys;
              inherit lib modulesPath;
              inherit inputs self inputs' self';
            }
            specialArgs;
        }
        // (builtins.removeAttrs args ["withSystem" "system" "hostName" "modules" "specialArgs"])));
in {
  inherit mkSystem mkNixosSystem;
}
