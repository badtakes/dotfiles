{self, ...}: {
  system = {
    autoUpgrade.enable = false;
    configurationRevision = self.shortRev or self.dirtyShortRev;
  };

  # Preserve the flake that built the active system revision in /etc
  # for easier rollbacks with nixos-enter in case we contain changes
  # that are not yet staged.
  environment.etc."dotfiles".source = self;
}
