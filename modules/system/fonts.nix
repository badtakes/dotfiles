{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;

    enableDefaultPackages = true;

    packages = with pkgs; let
      patchNerdFont = drv:
        stdenvNoCC.mkDerivation {
          name = "${drv.meta.name}-nerd";
          version = "${drv.version}-${nerd-font-patcher.version}";

          src = drv;

          nativeBuildInputs = [nerd-font-patcher] ++ (with python3Packages; [python fontforge]);

          buildPhase = ''
            runHook preBuild
            mkdir -p build/
            for f in share/fonts/truetype/*; do
              nerd-font-patcher $f --complete --no-progressbars --outputdir build
              # note: this will *not* return an error exit code on failure, but instead
              # write out a corrupt file, so an additional check phase is required
            done
            runHook postBuild
          '';

          doCheck = true;
          checkPhase = ''
            runHook preCheck
            # Try to open each font. If a corrupt font was written out, this should fail
            for f in build/*; do
                fontforge - <<EOF
            try:
              fontforge.open(''\'''${f}')
            except:
              exit(1)
            EOF
            done
            runHook postCheck
          '';

          installPhase = ''
            runHook preInstall
            mkdir -p $out/share/fonts/truetype/
            install -Dm 444 build/* $out/share/fonts/truetype/
            runHook postInstall
          '';
        };

      mkZedFont = name: hash:
        stdenv.mkDerivation rec {
          inherit name;
          version = "1.2.0";

          src = fetchzip {
            inherit hash;

            url = "https://github.com/zed-industries/zed-fonts/releases/download/${version}/${name}-${version}.zip";
            stripRoot = false;
          };

          installPhase = ''
            runHook preInstall

            install -Dm644 *.ttf -t $out/share/fonts/truetype

            runHook postInstall
          '';
        };

      zed-mono = mkZedFont "zed-mono" "sha256-k9N9kWK2JvdDlGWgIKbRTcRLMyDfYdf3d3QTlA1iIEQ=";
      zed-sans = mkZedFont "zed-sans" "sha256-BF18dD0UE8Q4oDEcCf/mBkbmP6vCcB2vAodW6t+tocs=";
      # iosevka-comfy-nerd = patchNerdFont iosevka-comfy.comfy;
      # iosevka-comfy-motion-nerd = patchNerdFont iosevka-comfy.comfy-motion;
    in [
      corefonts
      font-awesome
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      ny
      sf-mono
      sf-pro
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese

      iosevka-comfy.comfy
      iosevka-comfy.comfy-motion

      # iosevka-comfy-nerd
      # iosevka-comfy-motion-nerd

      zed-mono
      zed-sans
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["IosevkaComfyMotion Nerd Font" "Noto Sans Mono"];
        serif = ["New York" "Noto Serif" "Source Han Serif"];
        sansSerif = ["IosevkaComfyMotion Nerd Font" "Noto Sans" "Source Han Sans"];
      };
    };
  };
}
