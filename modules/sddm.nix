{
  config,
  pkgs,
  inputs,
  lib,
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
    pkgs.libsForQt5.qt5ct
    pkgs.kdePackages.qt6ct
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.kdePackages.qtstyleplugin-kvantum
  ];

  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [ sddm-astronaut-custom ];
    enableHidpi = true;
    settings.General = {
      GreeterEnvironment = "QT_QPA_PLATFORMTHEME=qt5ct,QT_STYLE_OVERRIDE=kvantum";
    };
  };

  systemd.services.display-manager = {
    postStart = ''
      ${pkgs.bash}/bin/bash -c 'set > /tmp/sddmvars.txt'
      cp /tmp/sddmvars.txt /home/ahd/sddmvars.txt
      chown ahd:users /home/ahd/sddmvars.txt || true
    '';
    serviceConfig.Environment = (
      lib.mkForce "QT_SCALE_FACTOR=2"
    );
  };
}