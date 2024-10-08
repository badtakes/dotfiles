{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [birdtray thunderbird];

    programs.thunderbird = {
      enable = true;
      profiles."marco" = {
        isDefault = true;
      };
    };
  };
}
