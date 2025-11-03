{
  config,
  pkgs,
  inputs,
  ...
}:
let
  unstable = import <nixos-unstable> { };
in
{
  home.packages = with pkgs; [
    pwntools
    python313Packages.pwntools
    gdb
    avalonia-ilspy
    audacity
    sonic-visualiser
    zsteg
    qsstv
    stegsolve
    ghidra
    python313Packages.protobuf
    urh
  ];
}
