{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./dev.nix
    ./sec.nix
    ./misc.nix
    ./typst.nix
  ];
}
