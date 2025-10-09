{
  config,
  pkgs,
  inputs,
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
      background = [
        {
          monitor = "";
          path = "../wall.png"; # Only png supported
          blur_passes = 3; # 0 disables blur
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];
      input-field = [
        {
          monitor = "DP-1";
          size = "280, 80";
          outline_thickness = 2;
          outer_color = "$base";
          inner_color = "$base";
          font_color = "$text";
          fade_on_empty = false;
          placeholder_text = "pwd";
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          hide_input = false;
          position = "0, -120";
          halign = "center";
          valign = "center";
        }
      ];
      label = [
        # Current time
        {
          monitor = "";
          text = "$TIME";
          #inherit font_family;
          font_size = 120;
          color = "$text";
          position = "0, -300";
          valign = "top";
          halign = "center";
        }

        # User
        {
          monitor = "";
          text = ''$USER'';
          font_family = "Roboto";
          font_size = 35;
          color = "$overlay0";
          position = "0, -40";
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
