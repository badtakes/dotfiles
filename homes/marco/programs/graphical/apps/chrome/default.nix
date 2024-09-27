{lib, ...}: let
  inherit (lib) optionals concatStringsSep;

  isWayland = true;
in {
  programs.google-chrome = {
    enable = true;

    # extensions = [
    #   {id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # sponsor block
    #   {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock
    #   {id = "nngceckbapebfimnlniiiahkandclblb";} # bitwarden
    #   {id = "egnjhciaieeiiohknchakcodbpgjnchh";} # tab wrangler
    #   {id = "kbfnbcaeplbcioakkpcpgfkobkghlhen";} # grammarly
    # ];

    commandLineArgs =
      [
        # Experimental features
        "--enable-features=${
          concatStringsSep "," [
            "BackForwardCache:enable_same_site/true"
            "CopyLinkToText"
            "OverlayScrollbar"
            "TabHoverCardImages"
            "VaapiVideoDecoder"
          ]
        }"

        # Aesthetics
        "--force-dark-mode"

        # Performance
        "--enable-gpu-rasterization"
        "--enable-oop-rasterization"
        "--enable-zero-copy"
        "--ignore-gpu-blocklist"
      ]
      ++ optionals isWayland [
        # Wayland

        # Disabled because hardware acceleration doesn't work
        # when disabling --use-gl=egl, it's not gonna show any emoji
        # and it's gonna be slow as hell
        # "--use-gl=egl"

        "--ozone-platform=wayland"
        "--enable-features=UseOzonePlatform"
      ];
  };
}
