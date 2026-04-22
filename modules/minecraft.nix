{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  services.minecraft-servers = {
    enable = true;
    eula = true;
    servers.survival = {
      enable = true;
      package = inputs.nix-minecraft.packages.x86_64-linux.fabric-server; # or forge, etc.
      mods = inputs.nix-minecraft.lib.modrinthMods {
        mods = {
          "sodium" = {
            version = "mc1.21-0.5.8+build.1";
          };
          "lithium" = {
            version = "mc1.21-0.12.1";
          };
          "fabric-api" = {
            version = "0.100.1+1.21";
          };
          # ... add more by slug
        };
      };
    };
  };
}
