{
  config,
  pkgs,
  lib,
  inputs,
  #fetchurl,
  ...
}:

{

  services.minecraft-servers = {
    enable = true;
    eula = true;
    servers.htx = {
      enable = true;
      package = pkgs.neoforgeServers.neoforge-1_21_1;
      serverProperties = {
        gamemode = "survival";
        difficulty = "normal";
      };
      jvmOpts = "-Xmx8G -Xms1G";
      operators = {
        LegoLars2000 = "aabfb2ff-10a1-438a-baae-d1338d2457a2";
      };
      bannedPlayers = {
        Ruphles = "44e71430-f672-4545-af4e-b9a24e651d17";
      };
      symlinks =
        let
          modpack = (
            pkgs.fetchPackwizModpack {
              url = "https://raw.githubusercontent.com/axelhd/NixOS-Config/refs/heads/master/mods/pack.toml";
              packHash = "sha256-D5Umyhw6Nd6wRMOt0FBkSKqO0lnuoChYJ095UX02B0Y=";
            }
          );
        in
        {
          mods = "${modpack}/mods"; # modpackDrv;
        };
    };
  };

  services.restic.backups = {
    local = {
      paths = [
        "/srv"
      ];

      exclude = [
      ];
      initialize = true;
      pruneOpts = [
        "--keep-daily 7"
      ];
      timerConfig = {

        OnCalendar = "*:0/20";
        Persistent = true;
      };
      passwordFile = "/restic_password_mc.txt";
      repository = "/srv_bak";

    };
  };
}
