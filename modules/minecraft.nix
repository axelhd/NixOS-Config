{
  config,
  pkgs,
  lib,
  inputs,
  #fetchurl,
  ...
}:

let
  modpackTarball = pkgs.fetchurl {
    url = "10.0.0.8:8000/mods.tar.gz";
    hash = "sha256-sCv2svqXTvMqZgYovuN8oooVohoRn7n5cIqj2GWQ8tA=";
  };

  modpackDrv = pkgs.runCommand "modpack-mods" { } ''
    mkdir -p $out
    tar -xzf ${modpackTarball} -C $out # --strip-components=1
  '';

  jarFiles = builtins.filter (f: pkgs.lib.hasSuffix ".jar" (builtins.toString f)) (
    pkgs.lib.filesystem.listFilesRecursive modpackDrv
  );

  jarDrvs = builtins.map (
    f:
    pkgs.runCommand (baseNameOf (builtins.toString f)) { } ''
      cp ${f} $out
    ''
  ) jarFiles;
in

{

  services.minecraft-servers = {
    enable = true;
    eula = true;
    servers.htx = {
      enable = true;
      package = inputs.nix-minecraft.packages.x86_64-linux.fabric-server; # or forge, etc.
      operators = {
        LegoLars2000 = "aabfb2ff-10a1-438a-baae-d1338d2457a2";
      };
      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" jarDrvs;
      };
    };
  };
}
