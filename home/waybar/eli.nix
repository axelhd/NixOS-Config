{ config, pkgs, ... }:
{
  home.file.".config/waybar".source = ./eli;
}
