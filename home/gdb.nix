{ config, pkgs, ... }:

let
  peda = pkgs.fetchFromGitHub {
    owner = "longld";
    repo = "peda";
    rev = "master"; # You can pin a commit hash instead
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Replace with actual hash
  };
in
{
  home.file.".peda/peda.py".source = "${peda}/peda.py";

  home.file.".gdbinit".text = ''
    source ~/.peda/peda.py
  '';
}
