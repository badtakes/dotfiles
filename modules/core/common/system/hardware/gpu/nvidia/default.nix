{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkMerge;

  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  config = {
    # nvidia drivers are unfree software
    nixpkgs.config.allowUnfree = true;

    services.xserver = mkMerge [
      {
        videoDrivers = ["nvidia"];
      }
    ];

    # blacklist nouveau module so that it does not conflict with nvidia drm stuff
    # also the nouveau performance is godawful, I'd rather run linux on a piece of paper than use nouveau
    # no offense to nouveau devs, I'm sure they're doing their best and they have my respect for that
    # but their best does not constitute a usable driver for me
    # boot.blacklistedKernelModules = ["nouveau"];

    environment = {
      sessionVariables = mkMerge [
        {LIBVA_DRIVER_NAME = "nvidia";}

        {
          WLR_NO_HARDWARE_CURSORS = "1";
          #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
          #GBM_BACKEND = "nvidia-drm"; # breaks firefox apparently
        }
      ];
      systemPackages = with pkgs; [
        nvtopPackages.nvidia

        # mesa
        mesa

        # vulkan
        vulkan-tools
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer

        # libva
        libva
        libva-utils

        nvidia-offload
      ];
    };

    hardware = {
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.production;

        modesetting.enable = true;
        powerManagement.enable = true;

        # use open source drivers by default, hosts may override this option if their gpu is
        # not supported by the open source drivers
        open = true;
        nvidiaSettings = false; # add nvidia-settings to pkgs, useless on nixos
        # nvidiaPersistenced = true;
        # forceFullCompositionPipeline = true;

        forceFullCompositionPipeline = true;
      };

      graphics = {
        extraPackages = with pkgs; [nvidia-vaapi-driver];
        extraPackages32 = with pkgs.pkgsi686Linux; [nvidia-vaapi-driver];
      };
    };
  };
}
