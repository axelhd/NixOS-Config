final: prev: {
  qtwebengine = prev.qtwebengine.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      patchShebangs .
    '';
  });
}