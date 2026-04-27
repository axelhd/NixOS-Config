{config, pkgs, ...}:

{
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
}