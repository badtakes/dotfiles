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
    musnix = inputs.musnix.nixosModules.musnix;
    homeManager = inputs.home-manager.nixosModules.home-manager;

    modulesPath = ../modules;

    base = modulesPath + /base;
    system = modulesPath + /system;

    homesPath = ../homes;
    homes = [homeManager homesPath];
    shared = [agenix musnix];

    mkModulesFor = hostName: {
      modules ? [base system],
      extra ? [],
    }:
      flatten (concatLists [
        (singleton ./${hostName}/host.nix)
        (map (path: mkModuleTree' {inherit path;}) (concatLists [modules]))
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
        extra = [homes chaotic shared] ++ hardware;
      };
  };
}
