{ config, pkgs, ... }:

let
  peda = pkgs.fetchFromGitHub {
    owner = "longld";
    repo = "peda";
    rev = "master"; # You can pin a commit hash instead
    sha256 = "1121pgg2v7vfk46fikys5zb73dia5l65zj3z49kdcln2c7slklxy"; # nix-prefetch-url --unpack https://github.com/longld/peda/archive/refs/heads/master.tar.gz
  };
  gdbWithSix = pkgs.gdb.override {
    pythonSupport = true;
    python3 = pkgs.python3.withPackages (ps: with ps; [ six ]);
  };
in
{
  home.packages = [
    gdbWithSix
  ];

  home.file.".peda/peda.py".source = "${peda}/peda.py";

  home.file.".gdbinit".text = ''
    source ~/.peda/peda.py
  '';
}
