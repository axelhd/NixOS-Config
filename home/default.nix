{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.username = "ahd";
  home.homeDirectory = "/home/ahd";

  imports = [
    #inputs.rednix.container
    #inputs.everforest.homeModules.everforest
    inputs.nvf.homeManagerModules.default
    ./nvf.nix
    ./nvchad.nix # Disabled
    ./programs.nix
    #    ./unstable-programs.nix
    ./terminal.nix
    ./hyprland
    ./hollywood.nix
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
      gtk-theme = "Breeze-Dark";
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

  gtk = {
    #enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.kdePackages.breeze-icons;
    };
    cursorTheme = {
      name = "breeze_cursors";
      package = pkgs.kdePackages.breeze;
    };

    # Additional GTK settings for dark theme
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # Set Qt environment variables for Breeze Dark
  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "breeze-dark"; # For Qt5 applications
    QT_QPA_PLATFORMTHEME = "qt5ct"; # Use qt5ct for theming (optional)
  };

  # Ensure qt5ct and qt6ct are configured
  home.file.".config/qt5ct/qt5ct.conf".text = ''
    [Appearance]
    style=Breeze-Dark
    color_scheme_path=/usr/share/color-schemes/BreezeDark.colors
  '';

  home.file.".config/qt6ct/qt6ct.conf".text = ''
    [Appearance]
    style=Breeze-Dark
    color_scheme_path=/usr/share/color-schemes/BreezeDark.colors
  '';

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
