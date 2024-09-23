{lib, ...}: let
  inherit (builtins) filter map toString elem;
  inherit (lib) filesystem strings;

  mkModuleTree = {
    path,
    ignored ? [./default.nix],
  }:
    filter (strings.hasSuffix ".nix") (
      map toString (
        filter (path: !elem path ignored) (filesystem.listFilesRecursive path)
      )
    );

  mkModuleTree' = {
    path,
    ignored ? [],
  }: (filter (strings.hasSuffix "module.nix") (
    map toString (
      filter (path: !elem path ignored) (filesystem.listFilesRecursive path)
    )
  ));
in {
  inherit mkModuleTree mkModuleTree';
}
