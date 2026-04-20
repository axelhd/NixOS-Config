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

    nnn
    calibre
    pandoc

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc
    # cowsay
    mangohud
    file
    which
    pixieditor
    tree
    element-desktop
    gnused
    gnutar
    gawk
    zstd
    gnupg
    # the-powder-toy
    musescore
    gamma-launcher
    bottles

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    glow # markdown previewer in terminal

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring
    atop
    htop
    nvtopPackages.full

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    obsidian
    #imhex

    pavucontrol
    volctl
    playerctl
    # thunar
    # nemo
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.qtsvg
    kdePackages.kio-fuse # to mount remote filesystems via FUSE
    kdePackages.kio-extras # extra protocols support (sftp, fish and more)
    kdePackages.gwenview
    thunderbird
    firefox
    #wine
    keepassxc
    signal-desktop
    ipfetch

    firefox
    kdePackages.okular
    imagemagick

    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.da_DK
    hunspellDicts.en_GB-large
    # xclicker
    #kdePackages.kwallet
    bc
    kdePackages.ark
    qalculate-gtk
    spotdl
    yt-dlp
    foliate
    vlc
    xnec2c
    openscad
    gnome-terminal
    streamcontroller
    #fontforge
    fontforge-gtk
    #freecad
    (pkgs.symlinkJoin {
      name = "freecad";
      buildInputs = [ pkgs.makeWrapper ];
      paths = [ pkgs.freecad ];
      postBuild = ''
        wrapProgram $out/bin/freecad \
          --set QT_QPA_PLATFORM xcb
      '';
    })
    inkscape

    lutris
    jstest-gtk
    linuxConsoleTools
    opentrack
    ckan
    # cool-retro-term
    digikam
    blueman
    gimp3-with-plugins
    # alvr
    # webcamoid
    evtest
    evtest-qt
    kew
    # r2modman
    obs-studio
    # discord
    # vesktop
    lorien
    ffmpeg_6-full
    zoxide
    #dconf
    redshift
    #geogebra
    geogebra6
    # lunar-client
    # wxmaxima
    # maxima
    # wsjtx
    caligula
    lm_sensors
    # element
    # element-desktop
    darktable
    # aseprite
    #krita
    google-fonts
    # cdparanoia
    abcde
    # pywal
    # pipes-rs
    # prismlauncher
    # themechanger
    # davinci-resolve
    # steamcmd
    #kdePackages.kdenlive
    forge-mtg
    # pscircle
    (pkgs.symlinkJoin {
      name = "upscayl";
      paths = [ pkgs.upscayl ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/upscayl \
          --set __EGL_VENDOR_LIBRARY_FILENAMES /run/opengl-driver/share/glvnd/egl_vendor.d/10_nvidia.json
      '';
    })
    arma3-unix-launcher
    protonup-qt
    rar
    wineWow64Packages.stagingFull
    #cinny-desktop
    ncdu

    (modrinth-app.overrideAttrs (oldAttrs: {
      buildCommand = ''
        					gappsWrapperArgs+=(
        						--set GDK_BACKEND x11
        						--set WEBKIT_DISABLE_DMABUF_RENDERER 1
        					)
        				''
      + oldAttrs.buildCommand;
    }))

  ];
  /*
    programs.obs-studio.package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );
  */

  programs.beets = {
    enable = false; # Build fails
    settings = {
      library = "~/Music/beets/library.db";
      directory = "~/Music/cd";
      import = {
        move = false;
        write = true;
        copy = false;
        autotag = true;
        fetchart = true;
        resume = true;
      };
      paths.default = "$albumartist/$album/$track.$title";
      plugins = "fetchart";
      fetchart = {
        auto = true;
        cautious = true;
        minwidth = 300;
        cover_names = "cover front folder";
      };
    };
  };

  home.file.".abcde.conf".source = ../abcde.conf;
  #home.file.".config/beets/config.yaml".source = ../beets.yaml;

}
