{lib, ...}: let
  inherit (lib) mkOption types;
in rec {
  mkAttrsOption = description:
    mkOption {
      inherit description;
      default = {};
      type = types.attrs;
    };

  mkHexColorOption = description:
    mkOption {
      inherit description;
      example = "#424242";
      type = types.strMatching "#[0-9A-F]{6}";
    };

  mkBoolOption = default: description:
    mkOption {
      inherit description default;
      type = types.bool;
    };

  mkPkgOption = default: description:
    mkOption {
      inherit default description;
      type =
        if default == null
        then types.nullOr types.package
        else types.package;
    };

  mkPkgsOption = description:
    mkOption {
      inherit description;
      default = [];
      type = types.listOf types.package;
    };

  mkStrOption = description:
    mkOption {
      inherit description;
      type = types.str;
    };

  mkStrsOption = description:
    mkOption {
      inherit description;
      default = [];
      type = types.listOf types.str;
    };

  mkPathOption = description:
    mkOption {
      inherit description;
      type = types.path;
    };
}
