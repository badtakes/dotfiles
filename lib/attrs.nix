{lib, ...}: let
  inherit (lib) concatStringsSep isAttrs flip pipe mapAttrsRecursive collect listToAttrs;

  flattenAttrs' = let
    expandAttr = path: value: {
      inherit value;
      name = concatStringsSep "." path;
      __expanded__ = true;
    };
    isExpanded = v: isAttrs v -> v ? "__expanded__";
  in
    flip pipe [(mapAttrsRecursive expandAttr) (collect isExpanded) listToAttrs];
in {
  inherit flattenAttrs';
}
