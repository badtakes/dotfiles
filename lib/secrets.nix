{
  inputs,
  lib,
  ...
}: let
  inherit (inputs) self;
  inherit (lib) mkIf;

  mkAgenixSecret = cond: {
    file,
    owner ? "root",
    group ? "root",
    mode ? "400",
  }:
    mkIf cond {
      file = "${self}/secrets/${file}";
      inherit group owner mode;
    };
in {
  inherit mkAgenixSecret;
}
