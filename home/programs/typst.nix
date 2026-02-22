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
    typst
    typstyle
    typst-live
    typstwriter

  ];


}
