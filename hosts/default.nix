{
  inputs,
  withSystem,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.self) lib;
    inherit (lib) mkModuleTree' mkNixosSystem;
    inherit (lib.lists) singleton concatLists flatten;

    nixosHardware = inputs.nixos-hardware.nixosModules;
    homeManager = inputs.home-manager.nixosModules.home-manager;
    # stylix = inputs.stylix.nixosModules.stylix;

    modulesPath = ../modules;

    coreModules = modulesPath + /core;
    # extraModules = modulesPath + /extra;
    options = modulesPath + /options;

    common = coreModules + /common;
    profiles = coreModules + /profiles;

    # iso = coreModules + /roles/iso;
    # headless = coreModules + /roles/headless;
    graphical = coreModules + /roles/graphical;
    workstation = coreModules + /roles/workstation;
    # server = coreModules + /roles/server;
    laptop = coreModules + /roles/laptop;

    # shared = extraModules + /shared;

    homesPath = ../homes;
    homes = [homeManager homesPath];

    mkModulesFor = hostName: {
      modules ? [common profiles options],
      roles ? [],
      extra ? [],
    }:
      flatten (concatLists [
        (singleton ./${hostName}/host.nix)
        (map (path: mkModuleTree' {inherit path;}) (concatLists [modules roles]))
        extra
      ]);

    mkNixosSystem' = hostName: system: options:
      mkNixosSystem {
        inherit withSystem hostName system;
        modules = mkModulesFor hostName options;
      };
  in {
    shrine = mkNixosSystem' "shrine" "x86_64-linux" {
      roles = [graphical laptop workstation];
      extra = let
        hardware = with nixosHardware; [
          common-pc-laptop
          common-pc-laptop-ssd

          common-cpu-intel
          common-gpu-nvidia-sync
        ];
      in
        [homes] ++ hardware;
    };
  };
}
