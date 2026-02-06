{ stdenv, fetchurl, fontconfig, lib }:

stdenv.mkDerivation {
  pname = "fragile-bombers-attack";
  version = "1.0";

  src = ./fragile_bombers;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    cp -r $src $out/share/fonts/opentype/
  '';

  meta = {
    description = "Fragile Bombers Attack font";
    license = lib.licenses.publicDomain;
    homepage = "https://www.typodermicfonts.com";
  };
}
