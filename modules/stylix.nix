{
  config,
  inputs,
  pkgs,
  ...
}:

{
  stylix = {
    enable = true;
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
    image = ../home/wallpapers/stalker/strelok_night.jpg;

    fonts = {
      monospace = {
        #package = pkgs.nerd-fonts.jetbrains-mono;
        #name = "JetBrainsMono Nerd Font Mono";
        package = pkgs.nerd-fonts.go-mono;
        name = "GoMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 10;
        popups = 10;
      };
    };

    polarity = "dark";

    autoEnable = true;
    #targets.kde.enable = true;
  };
}
