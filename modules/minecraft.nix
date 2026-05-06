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
        difficulty = "hard";
      };
      jvmOpts = "-Xmx8G -Xms1G";
      operators = {
        LegoLars2000 = "aabfb2ff-10a1-438a-baae-d1338d2457a2";
      };
      bannedPlayers = {
        Ruphles = "44e71430-f672-4545-af4e-b9a24e651d17";
      };
      files."config/artifacts/items.toml" = ../mc_conf/artifacts-items.toml;
      files."config/create-server.toml" = ../mc_conf/create-server.toml;
      files."config/simplyswords/gem_powers.toml" = ../mc_conf/simplyswords/gem_powers.toml;
      files."config/simplyswords/general.toml" = ../mc_conf/simplyswords/general.toml;
      files."config/simplyswords/loot.toml" = ../mc_conf/simplyswords/loot.toml;
      files."config/simplyswords/status_effects.toml" = ../mc_conf/simplyswords/status_effects.toml;
      files."config/simplyswords/unique_effects.toml" = ../mc_conf/simplyswords/unique_effects.toml;
      files."config/simplyswords/weapon_attributes.toml" = ../mc_conf/simplyswords/weapon_attributes.toml;
      #files."config/simplswords/x.toml" = ../mc_conf/simplyswords/x.toml;
      symlinks =
        let
          modpack = (
            pkgs.fetchPackwizModpack {
              url = "https://codeberg.org/Axe/NixOS-Config/raw/branch/master/mods/pack.toml";
              packHash = "sha256-8STYxBzdoQBE6+UWUQHn7EQoPoR90wCbcNqE+eKjcyU=";
            }
          );
        in
        {
          mods = "${modpack}/mods"; # modpackDrv;
          #"config/artifacts/items.toml" = ../mc_conf/artifacts-items.toml;
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
