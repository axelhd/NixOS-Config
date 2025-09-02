{
  lib,
  stdenvNoCC,
  gtk3,
  breeze-icons,
  gnome-icon-theme,
  hicolor-icon-theme,
}:

stdenvNoCC.mkDerivation rec {
  pname = "vivid-glassy-dark-icons";
  version = "1.0.0";

  # Use a local folder as the source
  src = ./icons;

  nativeBuildInputs = [ gtk3 ];

  propagatedBuildInputs = [
    breeze-icons
    gnome-icon-theme
    hicolor-icon-theme
  ];

  installPhase = ''
    mkdir -p $out/share/icons/vivid-glassy-dark
    cp -r $src/* $out/share/icons/vivid-glassy-dark
    gtk-update-icon-cache $out/share/icons/vivid-glassy-dark
  '';

  dontDropIconThemeCache = true;

  meta = with lib; {
    description = "Vivid Glassy Dark icon theme for Hyprland and other GTK environments";
    homepage = "https://example.com/vivid-glassy-dark-icons"; # Replace with actual homepage if needed
    license = licenses.gpl3Only; # Adjust if necessary
    platforms = platforms.unix;
    maintainers = with lib.maintainers; [ ]; # Add maintainers if needed
  };
}
