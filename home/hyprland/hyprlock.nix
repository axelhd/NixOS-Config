{
  config,
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };
      background = lib.mkForce [
        {
          monitor = "";
          #path = "../wallpapers/leaf-16-10.png"; # Only png supported
          path = "screenshot";
          blur_passes = 1; # 0 disables blur
          contrast = 0.9;
          brightness = 0.8;
          vibrancy = 0.15;
          vibrancy_darkness = 0.0;
        }
      ];
      input-field = lib.mkForce [
        {
          monitor = "";
          size = "280, 80";
          outline_thickness = 2;
          #outer_color = "$base";
          #inner_color = "$base";
          #font_color = "$text";
          fade_on_empty = false;
          placeholder_text = "pwd";
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          hide_input = false;
          position = "0, -120";
          halign = "center";
          valign = "center";
          outer_color = "rgb(${config.lib.stylix.colors.base03})"; # Border
          inner_color = "rgb(${config.lib.stylix.colors.base00})"; # Background
          font_color = "rgb(${config.lib.stylix.colors.base05})"; # Text/dots
          fail_color = "rgb(${config.lib.stylix.colors.base08})"; # Error
          check_color = "rgb(${config.lib.stylix.colors.base0A})"; # Success
        }
      ];
      label = [
        # Current time
        {
          monitor = "";
          text = "$TIME";
          #inherit font_family;
          font_size = 120;
          color = "$rgb(${config.lib.stylix.colors.base05})";
          position = "0, -300";
          valign = "top";
          halign = "center";
        }

        # User
        {
          monitor = "";
          text = "$USER@${osConfig.networking.hostName}";
          font_family = "${config.stylix.fonts.monospace.name}";
          font_size = 35;
          color = "rgb(${config.lib.stylix.colors.base05})";
          position = "0, -35";
          valign = "center";
          halign = "center";
        }
      ];
      animations = {
        enabled = true;
        fade_in = {
          duration = 300;
          bezier = "easeOutQuint";
        };
        fade_out = {
          duration = 300;
          bezier = "easeOutQuint";
        };
      };
    };
  };
}
