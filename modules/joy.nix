final: prev: {
  boot.kernelPatches = [
    {
      name = "input-key-max";
      patch = ./input-key-max.patch;
    }
  ];

  linuxHeaders = prev.linuxHeaders.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ./input-key-max.patch
    ];
  });

  SDL2 = prev.SDL2.overrideAttrs (old: {
    buildInputs = (old.buildInputs or [ ]) ++ [
      final.linuxHeaders
    ];
  });

}
