{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  buildInputs = [
    pkgs.SDL2
    pkgs.SDL2_ttf
    pkgs.SDL2_image
    pkgs.lutris
  ];
}
