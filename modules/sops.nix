{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/ahd/.config/sops/age/keys.txt";

  sops.secrets."cesar/restic" = { };
}
