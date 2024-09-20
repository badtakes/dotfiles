{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # for compatibility sake
    (pkgs.writeScriptBin "dmenu" ''exec ${lib.getExe tofi}'')
    tofi
    wtype
  ];

  xdg.configFile."tofi/config".text = let
    colors = {
      base00 = "#1e1e2e"; # Base
      base01 = "#181825"; # Mantle
      base02 = "#313244"; # Surface0
      base03 = "#45475a"; # Surface1
      base04 = "#585b70"; # Surface2
      base05 = "#cdd6f4"; # text
      base06 = "#f5e0dc"; # rosewater
      base07 = "#b4befe"; # lavender
      base08 = "#f38ba8"; # red
      base09 = "#fab387"; # peach
      base0A = "#a6e3a1"; # yellow
      base0B = "#94e2d5"; # green
      base0C = "#94e2d5"; # teal
      base0D = "#89b4fa"; # blue
      base0E = "#cba6f7"; # mauve
      base0F = "#f2cdcd"; # flamingo
    };
  in ''
    font = Iosevka Nerd Font
    font-size = 13
    horizontal = true
    anchor = top
    width = 100%
    height = 40
    outline-width = 0
    border-width = 0
    min-input-width = 120
    result-spacing = 30
    padding-top = 10
    padding-bottom = 10
    padding-left = 20
    padding-right = 0
    margin-top = 0
    margin-bottom = 0
    margin-left = 15
    margin-right = 0
    prompt-text = " "
    prompt-padding = 30
    background-color = ${colors.base00}
    text-color = ${colors.base05}
    prompt-color = ${colors.base00}
    prompt-background = ${colors.base0D}
    prompt-background-padding = 4, 10
    prompt-background-corner-radius = 12
    input-background = ${colors.base02}
    input-background-padding = 4, 10
    input-background-corner-radius = 12
    selection-color = ${colors.base01}
    selection-background = ${colors.base0D}
    selection-background-padding = 4, 10
    selection-background-corner-radius = 12
    selection-match-color = ${colors.base05}
    clip-to-padding = false
  '';
}
