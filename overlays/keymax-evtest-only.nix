final: prev:
let
  keyMax = "0x4ff";
  keyCnt = "0x500";
  addFlags = drv: drv.overrideAttrs (old: {
    NIX_CFLAGS_COMPILE = (old.NIX_CFLAGS_COMPILE or "")
      + " -UKEY_MAX -UKEY_CNT -DKEY_MAX=${keyMax} -DKEY_CNT=${keyCnt}";
  });
in {
  evtest = addFlags prev.evtest;
  evtest-qt = addFlags (prev.evtest-qt or prev.evtest);
  SDL2 = addFlags prev.SDL2;        # optional, for sdl2-jstest
  pkgsi686Linux = prev.pkgsi686Linux // {
    SDL2 = addFlags prev.pkgsi686Linux.SDL2;  # optional 32‑bit SDL tests
  };
}