{ config, pkgs, ... }:
{
  xdg.configFile."waybar".source = ./eli;
  programs.waybar.enable = true;
}
