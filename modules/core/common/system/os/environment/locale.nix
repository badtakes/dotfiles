{lib, ...}: let
  inherit (lib.modules) mkDefault;
in {
  services.xserver.xkb = {
    layout = "br";
    variant = "nodeadkeys";
  };

  i18n = let
    defaultLocale = "en_US.UTF-8";
    br = "pt_BR.UTF-8";
  in {
    inherit defaultLocale;

    extraLocaleSettings = {
      LANG = defaultLocale;
      LC_COLLATE = defaultLocale;
      LC_CTYPE = defaultLocale;
      LC_MESSAGES = defaultLocale;

      LC_ADDRESS = br;
      LC_IDENTIFICATION = br;
      LC_MEASUREMENT = br;
      LC_MONETARY = br;
      LC_NAME = br;
      LC_NUMERIC = br;
      LC_PAPER = br;
      LC_TELEPHONE = br;
      LC_TIME = br;
    };

    supportedLocales = mkDefault [
      "en_US.UTF-8/UTF-8"
      "pt_BR.UTF-8/UTF-8"
    ];
  };
}
