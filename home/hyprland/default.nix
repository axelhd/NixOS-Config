{
  config,
  pkgs,
  inputs,
  ...
}:

{

  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  home.packages = with pkgs; [
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
    rofi
    catppuccin-cursors.mochaMauve
    catppuccin-cursors.mochaDark
    #catppuccin-cursors.mochaLavender
    hyprshot
  ];

  catppuccin = {
    #enable = true;
    starship.enable = false;
    waybar.enable = false;
    nvim.enable = false;
    flavor = "mocha";
  };

  home.pointerCursor = {
    gtk.enable = true; # Enable GTK cursor support for compatibility
    x11.enable = true; # Enable X11 cursor support (optional, for XWayland apps)
    package = pkgs.catppuccin-cursors.mochaDark; # Your chosen Catppuccin cursor variant
    name = "Catppuccin-Mocha-Dark-Cursors"; # Must match the exact cursor theme name
    size = 24; # Adjust cursor size as needed
    hyprcursor = {
      enable = true; # Enable Hyprcursor support
      size = 24; # Optional: Set Hyprcursor-specific size (defaults to home.pointerCursor.size if null)
    };
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
          "battery"
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
            default = [
              ""
              ""
            ];
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
          format-icons = [
            "󱃃"
            "󰔏"
            "󱃂"
          ];
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

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
      };
    };
  };

  # Specify the CSS file for Waybar
  home.file.".config/waybar/style.css".source = ./waybar_style.css;
  # Optional: Hyprpaper configuration for wallpaper
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = /usr/share/backgrounds/sunset.jpg
    wallpaper = ,/usr/share/backgrounds/sunset.jpg
  '';
}
