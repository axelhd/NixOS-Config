{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.username = "ahd";
  home.homeDirectory = "/home/ahd";

  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
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
    ./stylix.nix
    ./yazi.nix
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
    # =========================
    # AUDIO → VLC
    # =========================
    "audio/mpeg" = "vlc.desktop";
    "audio/mp3" = "vlc.desktop";
    "audio/x-mp3" = "vlc.desktop";
    "audio/wav" = "vlc.desktop";
    "audio/x-wav" = "vlc.desktop";
    "audio/ogg" = "vlc.desktop";
    "audio/vorbis" = "vlc.desktop";
    "audio/x-vorbis+ogg" = "vlc.desktop";
    "audio/flac" = "vlc.desktop";
    "audio/x-flac" = "vlc.desktop";
    "audio/aac" = "vlc.desktop";
    "audio/mp4" = "vlc.desktop";
    "audio/x-m4a" = "vlc.desktop";
    "audio/x-ms-wma" = "vlc.desktop";
    "audio/x-aiff" = "vlc.desktop";
    "audio/opus" = "vlc.desktop";

    # =========================
    # VIDEO → VLC
    # =========================
    "video/mp4" = "vlc.desktop";
    "video/x-matroska" = "vlc.desktop"; # mkv
    "video/webm" = "vlc.desktop";
    "video/x-msvideo" = "vlc.desktop"; # avi
    "video/mpeg" = "vlc.desktop";
    "video/quicktime" = "vlc.desktop"; # mov
    "video/x-flv" = "vlc.desktop";
    "video/3gpp" = "vlc.desktop";
    "video/3gpp2" = "vlc.desktop";

    # =========================
    # IMAGES → Gwenview / GIMP
    # =========================
    "image/png" = "org.kde.gwenview.desktop";
    "image/jpeg" = "org.kde.gwenview.desktop";
    "image/jpg" = "org.kde.gwenview.desktop";
    "image/gif" = "org.kde.gwenview.desktop";
    "image/webp" = "org.kde.gwenview.desktop";
    "image/bmp" = "org.kde.gwenview.desktop";
    "image/tiff" = "org.kde.gwenview.desktop";
    "image/svg+xml" = "org.inkscape.Inkscape.desktop";

    # optional: open heavy editing formats in gimp
    "image/x-xcf" = "gimp.desktop";

    # =========================
    # DOCUMENTS → Okular / LibreOffice
    # =========================
    "application/pdf" = "org.kde.okular.desktop";

    "application/msword" = "libreoffice-writer.desktop";
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
      "libreoffice-writer.desktop";

    "application/vnd.ms-excel" = "libreoffice-calc.desktop";
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "libreoffice-calc.desktop";

    "application/vnd.ms-powerpoint" = "libreoffice-impress.desktop";
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" =
      "libreoffice-impress.desktop";

    "text/plain" = "org.kde.kate.desktop";
    "text/markdown" = "org.kde.kate.desktop";
    "text/x-python" = "org.kde.kate.desktop";
    "text/x-csrc" = "org.kde.kate.desktop";
    "text/x-c++src" = "org.kde.kate.desktop";
    "application/json" = "org.kde.kate.desktop";
    "application/xml" = "org.kde.kate.desktop";

    "application/epub+zip" = "com.github.johnfactotum.Foliate.desktop";

    # =========================
    # ARCHIVES → Ark
    # =========================
    "application/zip" = "org.kde.ark.desktop";
    "application/x-zip-compressed" = "org.kde.ark.desktop";
    "application/x-tar" = "org.kde.ark.desktop";
    "application/x-tar.gz" = "org.kde.ark.desktop";
    "application/gzip" = "org.kde.ark.desktop";
    "application/x-bzip2" = "org.kde.ark.desktop";
    "application/x-xz" = "org.kde.ark.desktop";
    "application/x-7z-compressed" = "org.kde.ark.desktop";
    "application/x-rar" = "org.kde.ark.desktop";

    # =========================
    # DIRECTORIES → Dolphin
    # =========================
    "inode/directory" = "org.kde.dolphin.desktop";

    # =========================
    # BROWSER → Firefox
    # =========================
    "text/html" = "firefox.desktop";
    "application/xhtml+xml" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";

    # =========================
    # MAIL → Thunderbird
    # =========================
    "x-scheme-handler/mailto" = "thunderbird.desktop";

    # =========================
    # TORRENTS → (optional if you install one)
    # =========================
    "application/x-bittorrent" = "org.qbittorrent.qBittorrent.desktop";
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "25.05";
  home.stateVersion = "26.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
