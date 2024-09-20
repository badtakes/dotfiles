{inputs, ...}: let
  inherit (inputs.nixpkgs) lib;

  library = let
    extensions = lib.composeManyExtensions [
      (_: _: inputs.nixpkgs.lib)
      (_: _: inputs.flake-parts.lib)
    ];

    fn = self: let
      import = path:
        builtins.import path {
          inherit inputs;
          lib = self;
        };
    in {
      extensions = {
        builders = import ./builders.nix;
        modules = import ./modules.nix;
        options = import ./options.nix;
        systemd = import ./systemd.nix;
        themes = import ./themes.nix;
      };

      inherit (self.extensions.builders) mkNixosSystem;
      inherit (self.extensions.modules) mkModuleTree;
      inherit (self.extensions.systemd) hardenService mkGraphicalService mkHyprlandService;
      inherit (self.extensions.themes) serializeTheme compileSCSS;
    };
  in
    (lib.makeExtensible fn).extend extensions;
in {
  perSystem = {
    # This is REAL magic, done by REAL magicians
    _module.args.lib = library;
  };

  flake = {
    lib = library;
  };
}
