{
  config,
  osConfig,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  inner_margin = "8"; # Has to be a string since it has to be used in CSS raw
  outer_margin = 8;
in
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        reload_style_on_change = true;

        fixed-center = true;

        spacing = 0;
        height = 0;
        margin-top = outer_margin;
        margin-right = outer_margin;
        margin-bottom = outer_margin;
        margin-left = outer_margin;

        modules-left = [
          "custom/notification"
          "clock"
          "custom/swall"
          "tray"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "mpris"
          "pipewire"
          "bluetooth"
          "network"
          "battery"
        ];
        "custom/swall" = {
          format = "SWall";
          #exec = "/home/ahd/wc/nix/home/swall";
          on-click = "/home/ahd/wc/axel-doc/kode/c/wall_switcher/cmake-build-release/dbtest";
        };
        tray = {
          icon-size = 14;
          spacing = 10;
        };
        "hyprland/workspaces" = {
          format = "{name}";
          format-icons = {
            active = "";
            default = "";
            empty = "";
          };
        };
        clock = {
          format = "{:%I:%M:%S %p} ";
          interval = 1;
          tooltip-format = "{calendar}";
          calender = {
            format = {
              today = "{}";
            };
          };
          actions = {
            on-click-right = "shift_down";
            on-click = "shift_up";
          };
        };
        network = {
          format-wifi = " ";
          format-ethernet = " ";
          format-disconnected = " ";
          tooltip-format-disconnected = "No connection";
          tooltip-format-wifi = "{essid} ({signalStrength}%)  ";
          tooltip-format-ethernet = "{ifname} 🖧 ";
          on-click = "kitty nmtui";
        };
        bluetooth = {
          format-on = "󰂯";
          format-off = "BT Off";
          format-disabled = "󰂲 BT Disabled";
          format-connected-battery = "{device_battery_percentage}% 󰂯";
          format-alt = "{device_alias} 󰂯";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\n{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\n{device_address}\n{device_battery_percentage}%";
          on-click-right = "blueman-manager";
        };
        battery = {
          interval = 30;
          states = {
            good = 95;
            warning = 40;
            critical = 30;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% 󰂄 ";
          format-alt = "{time} {icon}";
          format-icons = [
            "󰁻"
            "󰁼"
            "󰁾"
            "󰂀"
            "󰂂"
            "󰁹"
          ];
        };
        mpris = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} {dynamic}";
          player-icons = {
            default = "▶";
          };
          status-icons = {
            paused = "⏸";
          };
          max-length = 30;
        };
        pipewire = {
          format = "{volume}% {icon} {format_source}";
          format-muted = "{icon} {format_source}";
          muted-icon = "󰝟 ";
          format-icons = [
            " "
            " "
            " "
          ];
          format-source = " ";
          format-source-muted = "  ";
          tooltip-format = "Speaker: {volume}%\nMicrophone: {source_volume}%";
          on-click = "pavucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-middle = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          scroll-step = 5;
        };
      };
    };
    style = ''
      @define-color base00 #${config.lib.stylix.colors.base00};
      @define-color base01 #${config.lib.stylix.colors.base01};
      @define-color base02 #${config.lib.stylix.colors.base02};
      @define-color base03 #${config.lib.stylix.colors.base03};
      @define-color base04 #${config.lib.stylix.colors.base04};
      @define-color base05 #${config.lib.stylix.colors.base05};
      @define-color base06 #${config.lib.stylix.colors.base06};
      @define-color base07 #${config.lib.stylix.colors.base07};
      @define-color base08 #${config.lib.stylix.colors.base08};
      @define-color base09 #${config.lib.stylix.colors.base09};
      @define-color base0A #${config.lib.stylix.colors.base0A};
      @define-color base0B #${config.lib.stylix.colors.base0B};
      @define-color base0C #${config.lib.stylix.colors.base0C};
      @define-color base0D #${config.lib.stylix.colors.base0D};
      @define-color base0E #${config.lib.stylix.colors.base0E};
      @define-color base0F #${config.lib.stylix.colors.base0F};
      * {
          font-size:15px;
          font-family: "#${config.stylix.fonts.monospace.name}";
          min-height: 0;
          border: none;
          border-radius: 5px;
          font-weight: 500;
      }
      window#waybar{
          background: @base00;
          border: 2px solid @base03;
          border-radius: 10px;
      }
      .modules-left {
          padding:7px;
          margin:${inner_margin} 0 ${inner_margin} ${inner_margin};
          border-radius:10px;
          background: alpha(@base0F,1);
          border: 2px solid @base03
      }
      .modules-center {
          padding:7px;
          margin:${inner_margin} 0 ${inner_margin} 0;
          border-radius:10px;
          background: alpha(@base0F,1);
          border: 2px solid @base03
      }
      .modules-right {
          padding:7px;
          margin: ${inner_margin} ${inner_margin} ${inner_margin} 0;
          border-radius:10px;
          background: alpha(@base0F,1);
          border: 2px solid @base03
      }
      tooltip {
          background:@base00;
          color: @base05;
          border: 2px solid @base03
      }
      #clock:hover, #custom-pacman:hover, #custom-notification:hover,#bluetooth:hover,#network:hover,#battery:hover, #cpu:hover,#memory:hover,#temperature:hover{
          transition: all .3s ease;
          color:@base04;
      }
      #custom-notification {
          padding: 0px 5px;
          transition: all .3s ease;
          color:@base05;
      }
      #clock{
          padding: 0px 5px;
          color:@base05;
          transition: all .3s ease;
      }
      #custom-pacman{
          padding: 0px 5px;
          transition: all .3s ease;
          color:@base05;
      }
      #workspaces {
          padding: 0px 5px;
      }
      #workspaces button {
          all:unset;
          padding: 0px 5px;
          color: alpha(@base0E,.7);
          transition: all .2s ease;
      }
      #workspaces button:hover {
          color:@base0C;
          border: none;
          text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
          transition: all 1s ease;
      }
      #workspaces button.active {
          color: @base0D;
          border: none;
          text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
      }
      #workspaces button.empty {
          color: alpha(@base0E,.4);
          border: none;
          text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .2);
      }
      #workspaces button.empty:hover {
          color: rgba(0,0,0,0);
          border: none;
          text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
          transition: all 1s ease;
      }
      #workspaces button.empty.active {
          color: @base0D;
          border: none;
          text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
      }
      #bluetooth{
          padding: 0px 5px;
          transition: all .3s ease;
          color:@base05;
      }
      #mpris,
      #pipewire,
      #network{
          padding: 0px 5px;
          transition: all .3s ease;
          color:@base05;
      }
      #battery{
          padding: 0px 5px;
          transition: all .3s ease;
          color:@base05;
      }
      #battery.charging {
          color: #26A65B;
      }
      #battery.warning:not(.charging) {
          color: #ffbe61;
      }
      #battery.critical:not(.charging) {
          color: #f53c3c;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
      #group-expand{
          padding: 0px 5px;
          transition: all .3s ease;
      }
      #custom-expand{
          padding: 0px 5px;
          color:alpha(@base05,.2);
          text-shadow: 0px 0px 2px rgba(0, 0, 0, .7);
          transition: all .3s ease;
      }
      #custom-expand:hover{
          color:rgba(255,255,255,.2);
          text-shadow: 0px 0px 2px rgba(255, 255, 255, .5);
      }
      #custom-colorpicker{
          padding: 0px 5px;
      }
      #cpu,#memory,#temperature{
          padding: 0px 5px;
          transition: all .3s ease;
          color:@base05;
      }
      #custom-endpoint{
          color:transparent;
          text-shadow: 0px 0px 1.5px rgba(0, 0, 0, 1);
      }
      #tray{
          padding: 0px 5px;
          transition: all .3s ease;
      }
      #tray menu * {
          padding: 0px 5px;
          transition: all .3s ease;
      }
      #tray menu separator {
          padding: 0px 5px;
          transition: all .3s ease;
      }
      #pipewire.muted {
        color: rgb(255, 0, 0);
      }
    '';
  };

}
