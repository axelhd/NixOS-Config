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
    rev = "246a76de1d6f2013409d9b8d68f525d9c3eab073";
    hash = "sha256-E5H33F1p83U2ZrotfrRKMbdr7lw3XJwXwe9Uwacmyic="; # lib.fakeSha256; # replace after first build
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
