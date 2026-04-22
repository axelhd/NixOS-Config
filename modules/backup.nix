{
  config,
  inputs,
  pkgs,
  ...
}:
let
  common = {

    paths = [
      # Home
      "/home/ahd/books"
      "/home/ahd/darksword"
      "/home/ahd/Games"
      "/home/ahd/ddc*"
      "/home/ahd/sh3"
      "/home/ahd/stalker"
      "/home/ahd/wc"

      # HDD 1
      "/data/hdd1/ahd/app" # SamSim
      "/data/hdd1/ahd/ddc2024"
      "/data/hdd1/ahd/DDCN2025"
      "/data/hdd1/ahd/Drone"
      # Deduplicate, can probably be deleted
      #"/data/hdd1/ahd/Photos"
      #"/data/hdd1/ahd/Pictures"
      "/data/hdd1/ahd/TDC*"
      "/data/hdd1/ahd/Liveries"
      "/data/hdd1/ahd/mc_fra_ahd-game"
      "/data/hdd1/ahd/Videos"
      "/data/hdd1/ahd/minecraft-roskilde"

      # HDD 2
      "/data/hdd2/Music"
      "/data/hdd2/Pictures"
      "/data/hdd2/archive"
      "/data/hdd2/blender"
      "/data/hdd2/diablo"
      "/data/hdd2/d2patch"
      "/data/hdd2/fnv_saves"
      "/data/hdd2/klaver_koncert"
      "/data/hdd2/magic_lantern"
      "/data/hdd2/poster"
      "/data/hdd2/ternet_ninja_3"

      "/data/hdd2/ahd/nvchad-config"
    ];

    exclude = [
    ];
    initialize = true;
    pruneOpts = [
      "--keep-monthly 2"
    ];
    timerConfig = {

      OnBootSec = "3m";
      OnCalendar = "daily";
      Persistent = true;
    };
    passwordFile = config.sops.secrets."cesar/restic".path;

  };
in

{
  services.restic.backups = {
    local_hdd1 = common // {
      repository = "/data/hdd1/restic_backup";
    };
    local_hdd2 = common // {
      repository = "/data/hdd2/restic_backup";
    };
  };
}
