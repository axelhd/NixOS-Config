{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "base16";
        version = "1.1";

        src = ./.;

        buildInputs = [
        ];

        nativeBuildInputs = [ ];

        installPhase = ''
          mkdir -p $out
          cp color.yaml $out/axe.yaml
        '';
      };
    };
}
