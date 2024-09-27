{lib, ...}: let
  inherit (lib) mkDefault;
in {
  security = {
    # sudo-rs.enable = mkForce false;

    sudo.enable = true;
    sudo.wheelNeedsPassword = mkDefault false;

    # sudo = {
    #   enable = true;
    #   wheelNeedsPassword = mkDefault false;
    # execWheelOnly = mkDefault false;

    # extraConfig = ''
    #   Defaults lecture = never # rollback results in sudo lectures after each reboot, it's somewhat useless anyway
    #   Defaults pwfeedback # password input feedback - makes typed password visible as asterisks
    #   Defaults env_keep += "EDITOR PATH DISPLAY" # variables that will be passed to the root account
    #   Defaults timestamp_timeout = 300 # makes sudo ask for password less often
    # '';

    # extraRules = let
    #   sudoRules = with pkgs; [
    #     {
    #       package = coreutils;
    #       command = "sync";
    #     }
    #     {
    #       package = hdparm;
    #       command = "hdparm";
    #     }
    #     {
    #       package = nixos-rebuild;
    #       command = "nixos-rebuild";
    #     }
    #     {
    #       package = nvme-cli;
    #       command = "nvme";
    #     }
    #     {
    #       package = systemd;
    #       command = "poweroff";
    #     }
    #     {
    #       package = systemd;
    #       command = "reboot";
    #     }
    #     {
    #       package = systemd;
    #       command = "shutdown";
    #     }
    #     {
    #       package = systemd;
    #       command = "systemctl";
    #     }
    #     {
    #       package = util-linux;
    #       command = "dmesg";
    #     }
    #     {
    #       package = docker;
    #       command = "docker";
    #     }
    #     {
    #       package = gnumake;
    #       command = "make";
    #     }
    #   ];

    #   mkSudoRule = rule: {
    #     command = getExe' rule.package rule.command;
    #     options = ["NOPASSWD"];
    #   };

    #   sudoCommands = map mkSudoRule sudoRules;
    # in [
    #   {
    #     groups = ["wheel"];
    #     commands = sudoCommands;
    #   }
    # ];
  };
}
