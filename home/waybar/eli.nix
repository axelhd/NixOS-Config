{ config, pkgs, ... }:
{
  home.file.".config/waybar".source = ./eli;
  programs.waybar.enable = true;
}
