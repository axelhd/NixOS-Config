{
  lib,
  stdenvNoCC,
  fetchFromGitea,
  kdePackages,
  formats,
  themeConfig ? null,
  embeddedTheme ? "astronaut",
}:
stdenvNoCC.mkDerivation rec {
  pname = "sddm-astronaut";
  version = "1.0-unstable-2025-01-05";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "Axe";
    repo = "sddm-phantom-theme";
    rev = "0acec8a7fdf639077be798cd97989974e64fa6b2";
    hash = "sha256-OEq04WzHaMbj+box/7StWL6pranU8WPVb8RcNaPP10g="; # lib.fakeSha256; # replace after first build
  };

  dontWrapQtApps = true;

  propagatedBuildInputs = with kdePackages; [
    qtsvg
    qtmultimedia
    qtvirtualkeyboard
  ];

  installPhase =
    let
      iniFormat = formats.ini { };
      configFile = iniFormat.generate "" { General = themeConfig; };

      basePath = "$out/share/sddm/themes/sddm-astronaut-theme";
      sedString = "ConfigFile=Themes/";
    in
    ''
      mkdir -p ${basePath}
      cp -r $src/* ${basePath}
    ''
    + lib.optionalString (embeddedTheme != "astronaut") ''

      # Replaces astronaut.conf with embedded theme in metadata.desktop on line 9.
      # ConfigFile=Themes/astronaut.conf.
      sed -i "s|^${sedString}.*\\.conf$|${sedString}${embeddedTheme}.conf|" ${basePath}/metadata.desktop
    ''
    + lib.optionalString (themeConfig != null) ''
      chmod u+w ${basePath}/Themes/
      ln -sf ${configFile} ${basePath}/Themes/${embeddedTheme}.conf.user
    '';

  meta = {
    description = "Modern looking qt6 sddm theme";
    homepage = "https://codeberg.org/${src.owner}/${src.repo}";
    license = lib.licenses.gpl3;

    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [
      danid3v
      uxodb
    ];
  };
}