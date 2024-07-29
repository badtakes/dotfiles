{
  inputs,
  withSystem,
  ...
}: let
  inherit (inputs.self) lib;
  inherit (lib) mkModuleTree;
  inherit (lib.lists) singleton concatLists flatten;

  mkModulesFor = hostName: {
    modules ? [],
    roles ? [],
    extra ? [],
  }:
    flatten (concatLists [
      (singleton ./${hostName}/host.nix)

      (map (path:
        mkModuleTree {
          inherit path;
          suffix = "module.nix";
        }) (concatLists [modules roles]))

      extra
    ]);

  mkNixosSystem = {
    hostName,
    system ? "x86_64-linux",
    modules ? {},
    specialArgs ? {},
    ...
  } @ args:
    lib.mkNixosSystem ({
        inherit withSystem system;
        inherit hostName specialArgs;

        modules = mkModulesFor hostName modules;
      }
      // (builtins.removeAttrs args ["hostName" "system" "modules" "specialArgs"]));

  mkNixosSystem' = hostName: modules: mkNixosSystem {inherit hostName modules;};
in {
  flake.nixosConfigurations = let
    modulesPath = ../modules;

    core = let
      path = modulesPath + /core;
    in {
      common = path + /common;
      profiles = path + /profiles;
    };

    extra = let
      path = modulesPath + /extra;
      homesPath = ../homes;
    in {
      shared = path + /shared;
      home = [inputs.nixos-hardware.nixosModules homesPath];
    };

    roles = let
      path = modulesPath + /core;
    in {
      graphical = path + /roles/graphical;
      workstation = path + /roles/workstation;
      laptop = path + /roles/laptop;
    };

    options = modulesPath + /options;
  in {
    shrine = mkNixosSystem' "shrine" {
      modules = [core.common core.profiles options];
      roles = [roles.graphical roles.workstation];
      extra = [extra.shared extra.home];
    };
  };
}
