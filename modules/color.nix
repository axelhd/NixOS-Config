{
  config,
  inputs,
  pkgs,
  ...
}:
{
  config.lib.stylix.colors = { # https://nix-community.github.io/stylix/styling.html
    base00 = "#0E1415"; # Default background
    base01 = "#296e7a"; # Alternate background
    base02 = "#293334"; # Selection background
    base03 = "#074853"; # Unfocused window border (hypr)
    base04 = "#6fccd6"; # Alternate text
    base05 = "#CECECE"; # Default text ; Window title text
    base06 = "#ee00ff"; # Undefined
    base07 = "#ee00ff"; # Undefined
    base08 = "#d91f1f"; # Error
    base09 = "#1410ff"; # Urgent ; Urgent window border (hypr)
    base0A = "#ffb348"; # Warning
    base0B = "#ee00ff"; # Undefined
    base0C = "#ee00ff"; # Undefined
    base0D = "#09a7c3"; # Focused window border (hypr, notif) ; Item on (dark bg)
    base0E = "#065260"; # Dark off (dark)
    base0F = "#ee00ff"; # Undefined
  };
}
