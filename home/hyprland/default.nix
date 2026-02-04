{
  config,
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}:

{

  imports = [
    inputs.catppuccin.homeModules.catppuccin
    #../waybar
    ../waybar/new.nix
    ./hyprlock.nix
  ];

  home.packages = with pkgs; [
    wofi
    waybar
    hyprpaper
    #dunst
    kitty
    swaylock
    wl-clipboard
    swww
    alacritty
    bemenu
    fuzzel
    hyprcursor
    rofi
    catppuccin-cursors.mochaDark
    #catppuccin-cursors.mochaLavender
    hyprshot
    nwg-look
  ];

  services.dunst = {
    enable = true;
    #configFile = ./dunstrc2;

    settings = {
    global = {
      monitor = 0;
      follow = "none";

      width = "100, 300";
      height = "0, 300";
      origin = "top-right";
      offset = "5, 15";
      scale = 0;
      notification_limit = 10;

      progress_bar = true;
      progress_bar_height = 14;
      progress_bar_frame_width = 0;
      progress_bar_min_width = 100;
      progress_bar_max_width = 300;
      progress_bar_corner_radius = 50;
      progress_bar_corners = "bottom-left,top-right";

      icon_corner_radius = 0;
      icon_corners = "all";

      indicate_hidden = true;
      transparency = 1;
      separator_height = 6;
      padding = 10;
      horizontal_padding = 8;
      text_icon_padding = 12;

      frame_width = 1;
      frame_color = lib.mkDefault "#a0a0a0";
      gap_size = 6;
      separator_color = lib.mkDefault "frame";
      sort = true;

      font = lib.mkDefault "Fira Mono 12";
      line_height = 0;
      markup = "full";
      format = "<b>%s</b>\n%b";
      alignment = "left";
      vertical_alignment = "center";
      show_age_threshold = -1;
      ellipsize = "middle";
      ignore_newline = false;
      stack_duplicates = true;
      hide_duplicate_count = false;
      show_indicators = true;

      enable_recursive_icon_lookup = true;
      icon_theme = lib.mkDefault "Adwaita, Papirus, Papirus-Dark";
      icon_position = "right";
      min_icon_size = 32;
      max_icon_size = 128;
      # icon_path = "/usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/";

      sticky_history = true;
      history_length = 30;

      dmenu = "/usr/bin/dmenu -l 10 -p dunst:";
      browser = "/usr/bin/xdg-open";
      always_run_script = true;
      title = "Dunst";
      class = "Dunst";

      corner_radius = 10;
      corners = "all";
      ignore_dbusclose = false;

      force_xwayland = false;
      force_xinerama = false;

      mouse_left_click = "close_current";
      mouse_middle_click = "do_action, close_current";
      mouse_right_click = "close_all";
    };

    experimental = {
      per_monitor_dpi = false;
    };

    urgency_low = {
      background = lib.mkDefault "#222222";
      foreground = lib.mkDefault "#ffffff";
      highlight = lib.mkDefault "#722ae6,#e4b5cb";
      timeout = 20;
    };

    urgency_normal = {
      background = lib.mkDefault "#222222";
      foreground = lib.mkDefault "#ffffff";
      frame_color = lib.mkDefault "#5e5086";
      highlight = lib.mkDefault "#722ae6,#e4b5cb";
      timeout = 20;
      override_pause_level = 30;
      default_icon = "dialog-information";
    };

    urgency_critical = {
      background = lib.mkDefault "#222222";
      foreground = lib.mkDefault "#ffffff";
      frame_color = lib.mkDefault "#d54e53";
      highlight = lib.mkDefault "#d54e53,#f0f0f0";
      timeout = 0;
      override_pause_level = 60;
      default_icon = lib.mkDefault "dialog-warning";
    };
  };

   /* settigs = {
      width = "(100, 300)";
      height = "(0, 300)";
      origin = "top-right";
      offset = "(5, 15)";
      progress_bar = true;
      progress_bar_height = 14;
      progress_bar_frame_width = 0;
      progress_bar_min_width = 100;
      progress_bar_max_width = 300;
      progress_bar_corner_radius = 50;
      progress_bar_corners = "bottom-left, top-right";
      icon_corner_radius = 5;
      icon_corners = "all";
      indicate_hidden = "yes";
      transparency = 50;
      separator_height = 6;
      padding = 10;
      horizontal_padding = 8;
      text_icon_padding = 12;
      frame_width = 1;
      frame_color = "#ff0000"; # TODO: replace with stylix value 
      gap_size = 6;
      separator_color = auto;
      markup = "full";
      format = "<b>%s</b>\n%b";
    }; */
  };

  programs.rofi = {
    enable = true;
    theme = lib.mkForce "/home/ahd/wc/nix/home/hyprland/rofi.rasi";
  };

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
      enable = false; # Enable Hyprcursor support
      size = 24; # Optional: Set Hyprcursor-specific size (defaults to home.pointerCursor.size if null)
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      #monitor = ",preferred,auto,1"; # Auto-configure monitors
      monitor =
        if (osConfig.networking.hostName == "cesar") then
          #if (config.networking.hostName == "cesar") then
          [
            "DP-1,1920x1080@60,1920x0,1"
            "DP-2,1920x1200@60,0x0,1"
            "DP-3,1920x1200@60,3840x0,1"
            ",preferred,auto,1"
          ]
        else
          [
            "eDP-1,1920x1080@60,0x0,1"
            "DP-3,1920x1080@60,1920x0,1"
            ",preferred,auto,1"
          ];
      xwayland = {
        force_zero_scaling = true;
      };

      # toolkit-specific scale
      device = {
        name = "wacom-cintiq-16-pen";
        output = "HDMI-A-1";
      };

      render = {
        direct_scanout = false;
      };

      exec-once = [
        "vlc --play-and-exit --fullscreen --no-video-title-show --quiet ~/wc/nix/home/hyprland/startup.mkv"
        "hyprpaper &" # Start wallpaper
        "waybar &" # Start waybar
        "dunst &" # Start notification daemon
        "/run/current-system/sw/bin/kwalletd6"
      ];
      input = {
        kb_layout = "dk";
        follow_mouse = 1;
      };
      general = {
        gaps_in = 5; # 5
        gaps_out = 10; # 10
        border_size = 1;
        "col.active_border" = lib.mkDefault "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = lib.mkDefault "rgba(595959aa)";
      };
      decoration = {
        rounding = 15;
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
      windowrule = [
        "match:title swall, float on, move 11 61"
      ];
      "$mod" = "SUPER";
      bind = [
        "$mod, W, layoutmsg, togglesplit"
        "$mod, P, layoutmsg, swapsplit"
        "$mod, T, exec, kitty" # Launch terminal
        "$mod, P, exec, thunar" # Launch dolphin
        "$mod, A, exec, rofi -show drun -show-icons" # Launch application menu
        "$mod, G, exec, fuzzel" # Launch application menu
        "$mod, Q, killactive," # Close active window
        "$mod, Å, exit," # Exit Hyprland session
        "$mod, F, togglefloating," # Toggle floating window
        "$mod, N, exec, wofi --show run" # Run command
        "$mod, R, fullscreen"
        "$mod, M, exec, kitty cmatrix"
        "$mod, K, exec, hyprlock"
        # Move focus
        "$mod, h, movefocus, l"
        "$mod, n, movefocus, d"
        "$mod, e, movefocus, u"
        "$mod, i, movefocus, r"
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
      dwindle = {
        preserve_split = true; # Needed to make togglesplit work
      };
    };
  };

  #home.file.".config/hypr/hyprpaper.conf".text = lib.mkDefault ''
  #  preload = /home/ahd/wc/nix/home/wall.png
  #  preload = /home/ahd/wc/nix/home/wallpapers/leaf-16-9.png
  #  preload = /home/ahd/wc/nix/home/wallpapers/leaf-16-10.png
  #  wallpaper = , /home/ahd/wc/nix/home/wallpapers/leaf-16-10.png
  #  wallpaper = DP-1, /home/ahd/wc/nix/home/wallpapers/leaf-16-9.png'';
}
