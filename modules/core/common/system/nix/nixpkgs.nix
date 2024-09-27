{
  nixpkgs = {
    config = {
      allowAliases = true;
      allowBroken = false;
      allowUnfree = true;
      allowUnsupportedSystem = true;

      permittedInsecurePackages = [];

      enableParallelBuildingByDefault = false;

      showDerivationWarnings = [];
    };
  };
}
