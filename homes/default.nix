{
  inputs',
  self',
  self,
  config,
  lib,
  ...
}: {
  home-manager = let
    inherit (self) inputs;

    extraSpecialArgs = {inherit inputs inputs' self self';};
  in {
    inherit extraSpecialArgs;

    useGlobalPkgs = true;
    useUserPackages = true;

    backupFileExtension = "hm.old";

    users = lib.genAttrs ["marco"] (name: ./${name} + /home.nix);

    sharedModules = [
      {
        nix.package = lib.mkForce config.nix.package;
        programs.home-manager.enable = true;

        manual = {
          manpages.enable = false;
          html.enable = false;
          json.enable = false;
        };
      }
    ];

    verbose = true;
  };
}
