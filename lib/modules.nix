{lib, ...}: let
  inherit (builtins) filter map toString elem;
  inherit (lib) filesystem strings;

  mkModuleTree = {
    path,
    suffix ? ".nix",
    ignore ? [./default.nix],
  }: let
    files = filesystem.listFilesRecursive path;
    paths = map toString (filter (path: !elem path ignore) files);
  in
    filter (strings.hasSuffix suffix) paths;
in {
  inherit mkModuleTree;
}
