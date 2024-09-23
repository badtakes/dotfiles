{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    podman-compose
    podman-desktop
  ];

  hardware.nvidia-container-toolkit.enable = builtins.any (driver: driver == "nvidia") config.services.xserver.videoDrivers;

  virtualisation = {
    containers.registries.search = [
      "docker.io"
      "quay.io"
      "ghcr.io"
      "gcr.io"
    ];

    podman = {
      enable = true;

      dockerCompat = true;
      dockerSocket.enable = true;

      defaultNetwork.settings.dns_enabled = true;

      autoPrune = {
        enable = true;
        flags = ["--all"];
        dates = "weekly";
      };
    };
  };
}
