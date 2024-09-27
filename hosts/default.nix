{
  inputs,
  withSystem,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.self) lib;
    inherit (lib) mkModuleTree' mkNixosSystem;
    inherit (lib.lists) singleton concatLists flatten;

    agenix = inputs.agenix.nixosModules.default;
    homeManager = inputs.home-manager.nixosModules.home-manager;

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

    # sharedModules = extraModules + /shared;

    homesPath = ../homes;
    homes = [homeManager homesPath];
    shared = [
      # sharedModules
      agenix
    ];

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
    shrine = let
      chaotic = inputs.chaotic.nixosModules.default;
      hardware = with inputs.nixos-hardware.nixosModules; [
        common-pc-laptop
        common-pc-laptop-ssd

        common-cpu-intel
        common-gpu-intel-disable
        common-gpu-nvidia-nonprime
      ];
    in
      mkNixosSystem' "shrine" "x86_64-linux" {
        roles = [graphical laptop workstation];
        extra = [homes chaotic shared] ++ hardware;
      };
  };
}
