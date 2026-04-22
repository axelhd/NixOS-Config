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
      package = pkgs.fabricServers.fabric-1_21_1.override; # or forge, etc.
      jvmOpts = "-Xmx8G -Xms1G";
      operators = {
        LegoLars2000 = "aabfb2ff-10a1-438a-baae-d1338d2457a2";
      };
      symlinks = {
        mods = modpackDrv;
      };
    };
  };
}
