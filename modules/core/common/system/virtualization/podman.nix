{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    podman-compose
    podman-desktop
  ];

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

      enableNvidia = builtins.any (driver: driver == "nvidia") config.services.xserver.videoDrivers;

      autoPrune = {
        enable = true;
        flags = ["--all"];
        dates = "weekly";
      };
    };
  };
}
