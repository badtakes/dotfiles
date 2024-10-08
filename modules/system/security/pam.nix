{
  security = {
    pam = {
      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];

      services = let
        ttyAudit = {
          enable = true;
          enablePattern = "*";
        };

        gnupg = {
          enable = true;
          noAutostart = true;
          storeOnly = true;
        };
      in {
        swaylock.text = "auth include login";

        login = {
          inherit gnupg ttyAudit;
          setLoginUid = true;
          enableGnomeKeyring = true;
        };

        sshd = {
          inherit ttyAudit;
          setLoginUid = true;
        };

        sudo = {
          inherit ttyAudit;
          setLoginUid = true;
        };

        greetd = {
          enableGnomeKeyring = true;
          inherit gnupg;
        };

        tuigreet = {
          enableGnomeKeyring = true;
          inherit gnupg;
        };
      };
    };
  };
}
