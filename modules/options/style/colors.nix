{
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkOption literalExpression;
  inherit (lib.types) str enum attrs;

  getSchemePalette = name:
    if builtins.pathExists ./palettes/${name}.nix
    then (import ./palettes/${name}.nix).scheme.palette
    else throw "The following scheme was imported but not found: ${name}";

  cfg = config.modules.style;
in {
  options.modules.style = {
    scheme = {
      name = mkOption {
        type = str;
        default = "black-metal-venom";
        description = ''
          The name of the colorscheme to use.
        '';
      };

      colors = mkOption {
        type = attrs;
        default = getSchemePalette cfg.scheme.name;
        description = ''
          An attribute set containing active colors of the system.
        '';
        example = literalExpression ''
          {
            base00 = "#000000";
            base01 = "#121212";
            base02 = "#222222";
            base03 = "#333333";
            base04 = "#999999";
            base05 = "#c1c1c1";
            base06 = "#999999";
            base07 = "#c1c1c1";
            base08 = "#5f8787";
            base09 = "#aaaaaa";
            base0A = "#79241f";
            base0B = "#f8f7f2";
            base0C = "#aaaaaa";
            base0D = "#888888";
            base0E = "#999999";
            base0F = "#444444";
          }
        '';
      };

      variant = mkOption {
        type = enum ["dark" "light"];
        default =
          if builtins.substring 0 1 cfg.scheme.colors.base00 < "5"
          then "dark"
          else "light";
        description = ''
          Whether the scheme is dark or light
        '';
      };
    };
  };
}
