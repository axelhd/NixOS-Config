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
    vscodium
    jekyll
    jetbrains.clion
    killall
    # jetbrains.dataspell
    jetbrains.pycharm
    # jetbrains.rust-rover
    # jetbrains.rider
    # jetbrains.idea
    # rustlings
    # dbeaver-bin
    # octaveFull
    godot
    git
    subversion
    python3
    lnav
    gnumake
    # rustup
    gcc
    kile
    texliveFull
    # rubber
    love
    luajit
    # lazarus-qt6
    # fpc
    sqlite
    # python313Packages.pip
    jdk25
    craftos-pc
    qcad
    wireguard-tools
    nim
    devenv
    #arduino-ide
    #arduino
    dfu-programmer
    dfu-util
    processing
    raylib
    libnotify
    sqlitestudio
    #yazi
  ];

  home.file.".wakatime.cfg".text = ''
    [settings]
    api_url = https://hackatime.hackclub.com/api/hackatime/v1
    api_key = 0d7d68c3-f4c4-4968-b055-b20648f6ae50
    heartbeat_rate_limit_seconds = 30
  '';
}
