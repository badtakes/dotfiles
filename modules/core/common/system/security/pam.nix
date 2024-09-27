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
      in {
        swaylock.text = "auth include login";

        login = {
          inherit ttyAudit;
          setLoginUid = true;
        };

        sshd = {
          inherit ttyAudit;
          setLoginUid = true;
        };

        sudo = {
          inherit ttyAudit;
          setLoginUid = true;
        };
      };
    };
  };
}
