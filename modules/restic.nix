{
  config,
  inputs,
  pkgs,
  ...
}:

{
  services.restic.backups = {
    home = {
      paths = [
        "/home/"
        "/data/hdd2/ahd/nvchad-config"
      ];

      exclude = [
        "/home/*/.cache"
        "/home/ahd/.local/share/Steam/"
        "/home/*/Games"
        "/home/ahd/VirtualBox VMs/win10game/"
        "/home/*/Downloads/"
        "/home/*/.local/share/bottles"
        "/home/*/.local/share/trash"
        "/home/ahd/stalker/"
        "/home/*/app"
        "/home/*/COPY"
        "/home/ahd/Music/non_cd(broken)/"
        "/home/ahd/maple2025"
        "/home/ahd/hdd2"
        "/home/ahd/dcs_wine_prefix"
        "/home/ahd/digikamdb"
        "/home/ahd/G.A.M.M.A._Launcher_v8.0"
        "/home/ahd/wc"
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
      # MAKE SOPS TEMPLATE
      passwordFile = "/home/ahd/wc/nix/restic_password";
      repositoryFile = "/data/hdd2/backup/home";

    };
  };
}
