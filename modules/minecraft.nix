{
  config,
  pkgs,
  lib,
  inputs,
  #fetchurl,
  ...
}:

let
  modpackDrv = pkgs.runCommand "modpack-mods" { } ''
    mkdir -p $out
    tar -xzf ${
      pkgs.fetchurl {
        url = "http://10.0.0.8:8000/mods.tar.gz";
        hash = "sha256-sCv2svqXTvMqZgYovuN8oooVohoRn7n5cIqj2GWQ8tA=";
      }
    } -C $out
  '';
in

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
              url = "https://codeberg.org/Axe/NixOS-Config/raw/branch/master/mods/pack.toml";
              packHash = "sha256-G3gq/tRnG0LnkAZoLxh4JokospbPZCBgLt7T3jSn26I=";
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
      passwordFile = "../restic_password_mc.txt";
      repository = "/srv_bak";

    };
  };
}
