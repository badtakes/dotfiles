{self, ...}: {
  system = {
    autoUpgrade.enable = false;
    configurationRevision = self.shortRev or self.dirtyShortRev;
  };

  environment.etc."nyx".source = self;
}
