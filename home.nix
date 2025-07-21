{ config, pkgs, inputs, ... }:

{
  home.username = "ahd";
  home.homeDirectory = "/home/ahd";

  # set cursor size and dpi for 4k monitor
  #xresources.properties = {
  #  "Xcursor.size" = 16;
  #  "Xft.dpi" = 172;
  #};

  imports = [
    inputs.nix4nvchad.homeManagerModule
    inputs.catppuccin.homeModules.catppuccin
    #inputs.rednix.container
    #inputs.everforest.homeModules.everforest
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    neofetch
    nnn

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
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
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
    git
    imhex
    
    wofi
    waybar
    hyprpaper
    dunst
    kitty
    swaylock
    wl-clipboard
    swww
    alacritty
    bemenu
    fuzzel
    hyprcursor

    pavucontrol
    volctl
    playerctl
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.qtsvg
    kdePackages.kio-fuse #to mount remote filesystems via FUSE
    kdePackages.kio-extras #extra protocols support (sftp, fish and more)
    kdePackages.gwenview
    darktable
    thunderbird
    #subversion
    python3
    python312Packages.numpy
    rustup
    gcc
    firefox
    lnav
    wine
    keepassxc
    signal-desktop
    ipfetch

    firefox
    rofi
    kile 
    texliveFull
    rubber
    kdePackages.okular
    imagemagick
    catppuccin-cursors.mochaMauve
    catppuccin-cursors.mochaDark
    catppuccin-cursors.mochaLavender

    hyprshot
    libreoffice-qt6-fresh
    xclicker
    subversion
    #kdePackages.kwallet
    bc
    qalculate-gtk
    spotdl
    yt-dlp
    vlc
    jetbrains.pycharm-community
    jetbrains.rust-rover
    xnec2c
    freecad
    blender
    openscad
    inkscape
    
    lutris
    jstest-gtk
    linuxConsoleTools
    opentrack
    ckan
    cool-retro-term
    digikam
    godot
    octaveFull
    gimp3-with-plugins
    flightgear
    alvr
    webcamoid
    evtest
    evtest-qt
    kew
    r2modman
    obs-studio
    discord
    vesktop
    ffmpeg_6-full
    zoxide
    ghidra
    #dconf
    dbeaver-bin
    redshift
    #geogebra
    geogebra6
    lunar-client
    modrinth-app
    jetbrains.pycharm-professional
    rustlings
    heroic
  ];

  #gtk.enable = true; # to enable the cursor theme on gtk apps
  #everforest.enable = true;

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Breeze-Dark";
    };
  };

  programs.obs-studio.package = (pkgs.obs-studio.override {
    cudaSupport = true;
  });

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Axel Hajslund Damgaard";
    userEmail = "axel@hajslunddamgaard.dk";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        #draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      eval "$(zoxide init bash)"
      export SVN_EDITOR=nvim
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };
  
  programs.nvchad = {
    enable = true;
    extraPackages = with pkgs; [
      nodePackages.bash-language-server
      docker-compose-language-service
      dockerfile-language-server-nodejs
      emmet-language-server
      nixd
      (python3.withPackages(ps: with ps; [
        python-lsp-server
        flake8
      ]))
      lua-language-server
      clang-tools
    ];
    hm-activation = true;
    backup = true;
  };
  
  catppuccin = {
    #enable = true;
    starship.enable = true;
    waybar.enable = false;
    nvim.enable = false;
    flavor = "mocha";
  };
  
  home.pointerCursor = {
    gtk.enable = true;  # Enable GTK cursor support for compatibility
    x11.enable = true;  # Enable X11 cursor support (optional, for XWayland apps)
    package = pkgs.catppuccin-cursors.mochaMauve;  # Your chosen Catppuccin cursor variant
    name = "Catppuccin-Mocha-Mauve-Cursors";  # Must match the exact cursor theme name
    size = 24;  # Adjust cursor size as needed
    hyprcursor = {
      enable = true;  # Enable Hyprcursor support
       size = 24;  # Optional: Set Hyprcursor-specific size (defaults to home.pointerCursor.size if null)
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

  wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        #monitor = ",preferred,auto,1"; # Auto-configure monitors
        monitor = [
	  "DP-1,1920x1200@60,1920x0,1"
          "DP-2,1920x1200@60,0x0,1"
          "DP-3,1920x1200@60,3840x0,1"
          ",preferred,auto,1"
      	];
        
        render = {
          direct_scanout = false;
        };

        exec-once = [
          "waybar &" # Start waybar
          "hyprpaper &" # Start wallpaper
          "dunst &" # Start notification daemon
          "/run/current-system/sw/bin/kwalletd6"
        ];
        input = {
          kb_layout = "dk";
          follow_mouse = 1;
        };
        general = {
          gaps_in = 2; # 5
          gaps_out = 4; # 10
          border_size = 1;
	  "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
        };
	decoration = {
          rounding = 5;
          #drop_shadow = true;
          #shadow_range = 4;
          #shadow_render_power = 3;
          #"col.shadow" = "rgba(1a1a1aee)";
        };
        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };
        "$mod" = "SUPER";
        bind = [
          "$mod, T, exec, alacritty" # Launch terminal
          "$mod, E, exec, dolphin" # Launch dolphin
          "$mod, D, exec, rofi -show drun -show-icons" # Launch application menu
          "$mod, G, exec, fuzzel" # Launch application menu
          "$mod, Q, killactive," # Close active window
          "$mod, M, exit," # Exit Hyprland session
          "$mod, F, togglefloating," # Toggle floating window
          "$mod, SPACE, exec, wofi --show run" # Run command
          "$mod, R, fullscreen"
          # Move focus
          "$mod, h, movefocus, l"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          "$mod, l, movefocus, r"
          # Switch workspaces
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"
          # Move window to workspace
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"
          # Screenshot (using flameshot, already in system packages)
          "$mod, S, exec, hyprshot -m region"
	        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

          # Media playback control
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
        ];
        bindm = [
          "$mod, mouse:272, movewindow" # Move window with mouse
          "$mod, mouse:273, resizewindow" # Resize window with mouse
        ];
      };
    };

    # Configure Waybar
    programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        modules-left = [
          "hyprland/workspaces"
          "custom/right-arrow-dark"
        ];
        modules-center = [
          "custom/left-arrow-dark"
          "clock#1"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "clock#2"
          "custom/right-arrow-dark"
          "custom/right-arrow-light"
          "clock#3"
          "custom/right-arrow-dark"
        ];
        modules-right = [
          "custom/left-arrow-dark"
          "pulseaudio"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "memory"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "cpu"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "temperature"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "disk"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
	  "temperature"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "tray"
        ];

        "custom/left-arrow-dark" = {
          format = "";
          tooltip = false;
        };
        "custom/left-arrow-light" = {
          format = "";
          tooltip = false;
        };
        "custom/right-arrow-dark" = {
          format = "";
          tooltip = false;
        };
        "custom/right-arrow-light" = {
          format = "";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          format = "{name}";
          on-click = "activate";
        };

        "clock#1" = {
          format = "{:%a}";
          tooltip = false;
        };
        "clock#2" = {
          format = "{:%H:%M}";
          tooltip = false;
        };
        "clock#3" = {
          format = "{:%m-%d}";
          tooltip = false;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = "MUTE";
          format-icons = {
            headphones = "";
            default = [ "" "" ];
          };
          scroll-step = 5;
          on-click = "pamixer -t";
          on-click-right = "pavucontrol";
        };

        memory = {
          interval = 5;
          format = "Mem {}%";
        };

        cpu = {
          interval = 5;
          format = "CPU {usage}%";
        };

	temperature = {
	  critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = [ "󱃃" "󰔏" "󱃂" ];
          on-click = "alacritty -e s-tui";
	};

        disk = {
          interval = 5;
          format = "Disk {percentage_used}%";
          path = "/";
        };

        tray = {
          icon-size = 20;
        };
      };
    };
  };

  # Specify the CSS file for Waybar
  home.file.".config/waybar/style.css".text = ''
    * {
        font-size: 20px;
        font-family: monospace;
    }

    window#waybar {
        background: #292b2e;
        color: #fdf6e3;
    }

    #custom-right-arrow-dark,
    #custom-left-arrow-dark {
        color: #1a1a1a;
    }
    #custom-right-arrow-light,
    #custom-left-arrow-light {
        color: #292b2e;
        background: #1a1a1a;
    }

    #workspaces,
    #clock-1{
        background: #1a1a1a;
    }
    #clock-2{
        background: #1a1a1a;
    }
    #clock-3{
        background: #1a1a1a;
    }
    #pulseaudio,
    #memory,
    #cpu,
    #battery,
    #disk,
    #temperature,
    #tray {
        background: #1a1a1a;
    }

    #workspaces button {
        padding: 0 2px;
        color: #fdf6e3;
    }
    #workspaces button.focused {
        color: #268bd2;
    }
    #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
    }
    #workspaces button:hover {
        background: #1a1a1a;
        border: #1a1a1a;
        padding: 0 3px;
    }

    #pulseaudio {
        color: #268bd2;
    }
    #memory {
        color: #2aa198;
    }
    #cpu {
        color: #6c71c4;
    }
    #battery {
        color: #859900;
    }
    #disk {
        color: #b58900;
    }
    #temperature {
        color: #dc322f;
        padding: 0 10px;
    }

    #clock-1{
        background: #1a1a1a;
    }
    #clock-2{
        background: #1a1a1a;
    }
    #clock-3{
        background: #1a1a1a;
    }
    #clock{
        background: #1a1a1a;
    }
    #pulseaudio,
    #memory,
    #cpu,
    #battery,
    #disk {
        padding: 0 10px;
    }
    #temperature {
        padding: 0 10px;
    }
  ''; 
    # Optional: Hyprpaper configuration for wallpaper
    home.file.".config/hypr/hyprpaper.conf".text = ''
      preload = /usr/share/backgrounds/sunset.jpg
      wallpaper = ,/usr/share/backgrounds/sunset.jpg
    '';


    #home.pointerCursor = {
      #gtk.enable = true; # Enable cursor for GTK applications
      #x11.enable = true; # Enable cursor for XWayland applications
      #package = pkgs.capitaine-cursors; # Cursor theme package
      #name = "capitaine-cursors"; # Cursor theme name
      #size = 24; # Cursor size (adjust as needed)
    #};

    #gtk = {
      #enable = true;
      #cursorTheme = {
        #package = pkgs.capitaine-cursors;
        #name = "capitaine-cursors";
      #};
    #};

  
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
    QT_STYLE_OVERRIDE = "breeze-dark";  # For Qt5 applications
    QT_QPA_PLATFORMTHEME = "qt5ct";    # Use qt5ct for theming (optional)
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
