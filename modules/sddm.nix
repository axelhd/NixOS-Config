{
  config,
  pkgs,
  inputs,
  ...
}:
let
  sddm-astronaut-custom = pkgs.callPackage ../pkgs/sddm-astronaut-custom.nix {
    # Optional overrides:
    themeConfig = {
      Background = "/path/to/wallpaper.png";
      Blur = "true";
    };

    embeddedTheme = "astronaut"; # or whatever variant you use
  };
in
{
  environment.systemPackages = [
    sddm-astronaut-custom
  ];

  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [ sddm-astronaut-custom ];
  };
}