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
    wacomtablet
  ];

  home.file."wacom-tablet-bindings.sh" = {
    target = ".config/system-scripts/wacom-tablet-bindings.sh";
    executable = true;
    text = ''
      #!/bin/bash

      ## Upper group of exprss keys
      xsetwacom set "Wacom Intuos Pro L Pad pad" Button 1 "key tab"
      xsetwacom set "Wacom Intuos Pro L Pad pad" Button 3 "key +control s -control"
      xsetwacom set "Wacom Intuos Pro L Pad pad" Button 2 "key insert"
      xsetwacom set "Wacom Intuos Pro L Pad pad" Button 8 "key alt"

      ## Center Button
      xsetwacom set "Wacom Intuos Pro L Pad pad" Button 13 "key +control z -control"
      ### This configuration leaves the default zoom-in/out touch ring bindings

      ## Lower group of express keys
      xsetwacom set "Wacom Intuos Pro L Pad pad" Button 9 "key +shift"
      xsetwacom set "Wacom Intuos Pro L Pad pad" Button 10 "key +control"
      xsetwacom set "Wacom Intuos Pro L Pad pad" Button 11 "key +t"
      xsetwacom set "Wacom Intuos Pro L Pad pad" Button 12 "key +b"


      ## Pen Controls
      xsetwacom set "Wacom Intuos Pro L Pen stylus" Button 3 "Key +e" # Toggles eraser mode on/off
      xsetwacom set "Wacom Intuos Pro L Pen eraser" Button 1 "key +p" # Horizontally mirrors canvas <- Rebind this to something else. I dont like the eraser key
    '';
  };
}
