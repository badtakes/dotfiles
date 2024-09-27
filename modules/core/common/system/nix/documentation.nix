{
  documentation = {
    doc.enable = true;
    info.enable = true;

    nixos = {
      enable = true;
      options = {
        warningsAreErrors = true;
        splitBuild = true;
      };
    };

    man = {
      enable = true;
      generateCaches = true;

      mandoc.enable = false;
    };
  };
}
