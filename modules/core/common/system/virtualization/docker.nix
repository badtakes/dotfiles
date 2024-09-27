{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    dive
    docker-compose
    oxker
  ];

  hardware.nvidia-container-toolkit.enable = builtins.any (driver: driver == "nvidia") config.services.xserver.videoDrivers;

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
  };
}
