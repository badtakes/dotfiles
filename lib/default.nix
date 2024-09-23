{inputs, ...}: let
  inherit (inputs.nixpkgs) lib;

  library = let
    extensions = lib.composeManyExtensions [
      (_: _: inputs.nixpkgs.lib)
      (_: _: inputs.flake-parts.lib)
    ];

    fn = self: let
      call = path:
        builtins.import path {
          inherit inputs;
          lib = self;
        };
    in {
      extensions = {
        builders = call ./builders.nix;
        modules = call ./modules.nix;
        options = call ./options.nix;
        systemd = call ./systemd.nix;
        themes = call ./themes.nix;
      };

      inherit (self.extensions.builders) mkNixosSystem;
      inherit (self.extensions.modules) mkModuleTree mkModuleTree';
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
