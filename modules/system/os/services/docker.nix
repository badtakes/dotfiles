{pkgs, ...}: {
  user.extraGroups = ["docker" "podman"];

  environment.systemPackages = with pkgs; [
    dive
    docker-compose
    oxker
  ];

  hardware.nvidia-container-toolkit.enable = true;

  virtualisation = {
    containers = {
      enable = true;

      registries.search = [
        "docker.io"
        "quay.io"
        "ghcr.io"
        "gcr.io"
      ];
    };

    docker = {
      enable = true;

      rootless.enable = true;
      rootless.setSocketVariable = true;

      autoPrune = {
        enable = true;
        flags = ["--all"];
        dates = "weekly";
      };
    };

    podman = {
      enable = true;

      defaultNetwork.settings.dns_enabled = true;

      autoPrune = {
        enable = true;
        flags = ["--all"];
        dates = "weekly";
      };
    };
  };
}
