final: prev:
let
  keyMax = "0x4ff";
  keyCnt = "0x500";

  # Create a derivation with the patched headers
  patchedLinuxHeaders = final.runCommand "patched-linux-headers" {} ''
    mkdir -p $out/include/linux
    src="${prev.linuxHeaders}/include/linux"

    # Copy necessary headers
    cp "$src/input.h" "$out/include/linux/"
    [ -f "$src/input-event-codes.h" ] && cp "$src/input-event-codes.h" "$out/include/linux/"

    # Patch the limits
    find $out/include/linux -type f -exec sed -i -E \
      -e 's/#define[[:space:]]+KEY_MAX[[:space:]]+.*/#define KEY_MAX ${keyMax}/' \
      -e 's/#define[[:space:]]+KEY_CNT[[:space:]]+.*/#define KEY_CNT ${keyCnt}/' \
      {} +
  '';

  # Helper to apply flags to a derivation
  addFlags = drv:
    if drv ? overrideAttrs then
      drv.overrideAttrs (old: {
        # Add our patched headers to buildInputs to ensure they are found
        buildInputs = [ patchedLinuxHeaders ] ++ (old.buildInputs or []);

        # Force inclusion via flags as a failsafe, and define macros explicitly
        NIX_CFLAGS_COMPILE = "-I${patchedLinuxHeaders}/include " + (old.NIX_CFLAGS_COMPILE or "")
          + " -UKEY_MAX -UKEY_CNT -DKEY_MAX=${keyMax} -DKEY_CNT=${keyCnt}";
      })
    else
      drv; # Fallback if not a valid derivation

in {
      # Native Linux apps
      SDL2 = addFlags prev.SDL2;
      sdl2-compat = addFlags (prev.sdl2-compat or prev.sdl2Compat or prev.sdl2-compat);
      SDL3 = if prev ? SDL3 then addFlags prev.SDL3 else null;

      # Override the 64-bit Wine packages.
      # Nixpkgs will automatically use these to build the final 'wineWowPackages'.
      winePackages = prev.winePackages // {
        stable = addFlags prev.winePackages.stable;
        staging = addFlags prev.winePackages.staging;
        unstable = addFlags prev.winePackages.unstable;
        full = addFlags prev.winePackages.full;
  };

  # 2. 32-bit packages
  # We override pkgsi686Linux to ensure the 32-bit wine build also gets the flags
  pkgsi686Linux = prev.pkgsi686Linux // {
    SDL2 = addFlags prev.pkgsi686Linux.SDL2;
    winePackages = prev.pkgsi686Linux.winePackages // {
      stable = addFlags prev.pkgsi686Linux.winePackages.stable;
      staging = addFlags prev.pkgsi686Linux.winePackages.staging;
    };
  };

  # 3. Wine WoW Packages (32-bit + 64-bit wrapper)
  # IMPORTANT: We must reconstruct this wrapper to point to our modified components above.
  # Otherwise, it continues to use the unpatched versions from 'prev'.
  wineWowPackages = prev.wineWowPackages // {
    staging = prev.wineWowPackages.staging.override {
      wineBuild = final.winePackages.staging;
      #pkgsi686Linux = final.pkgsi686Linux;
    };
    # You can do the same for stable/full if needed, e.g.:
    # stable = prev.wineWowPackages.stable.override {
    #   wineBuild = final.winePackages.stable;
    #   pkgsi686Linux = final.pkgsi686Linux;
    # };
  };
}