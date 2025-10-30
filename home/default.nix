{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.username = "ahd";
  home.homeDirectory = "/home/ahd";

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
  imports = [
    #inputs.rednix.container
    #inputs.everforest.homeModules.everforest
    inputs.nvf.homeManagerModules.default
    ./nvf.nix
    ./nvchad.nix # Disabled
    ./programs
    #    ./unstable-programs.nix
    ./terminal.nix
    ./hyprland
    ./hollywood.nix
    #./pwndbg.nix
    #inputs.pwndbg
    ./wacom.nix
  ];

  #gtk.enable = true; # to enable the cursor theme on gtk apps
  #everforest.enable = true;

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # Defaults

  xdg.desktopEntries.vlc = {
    name = "vlc";
    exec = "${pkgs.vlc}/bin/vlc";
  };

  xdg.mime.enable = true;
  xdg.mimeApps.defaultApplications = {
    "audio/mpeg" = "vlc.desktop"; # MP3
    "audio/x-wav" = "vlc.desktop"; # WAV
    "audio/ogg" = "vlc.desktop"; # OGG
    "audio/flac" = "vlc.desktop"; # FLAC
    "audio/aac" = "vlc.desktop"; # AAC
    "audio/mp4" = "vlc.desktop"; # M4A
    "audio/x-m4a" = "vlc.desktop"; # M4A (alternative)
    "audio/x-vorbis+ogg" = "vlc.desktop"; # OGG Vorbis
    "audio/x-ms-wma" = "vlc.desktop"; # WMA
    "audio/x-aiff" = "vlc.desktop"; # AIFF

  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
