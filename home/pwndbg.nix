{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.file.".gdbinit".text = ''
    source $(home-manager path)/share/pwndbg/gdbinit.py
  ''
}
