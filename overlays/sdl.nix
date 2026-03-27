self: prev:

let
  sdl2Compat' = prev.sdl2-compat.overrideAttrs (old: {
    buildInputs = (old.buildInputs or []) ++ [
      (prev.linuxHeaders.overrideAttrs (h: {
        patches = (h.patches or []) ++ [
          ./input-key-max.patch
        ];
      }))
    ];
  });

in {
  sdl2-compat = prev.sdl2-compat; # keep global unchanged

  wineWow64Packages = prev.wineWow64Packages // {
    stagingFull =
      prev.wineWow64Packages.stagingFull.overrideAttrs (old: {
        propagatedBuildInputs =
          (old.propagatedBuildInputs or [])
          |> map (pkg:
            if pkg.pname == "sdl2-compat" then sdl2Compat' else pkg
          );
      });
  };
}


/*
On NixOS, the clean way to do this is to **override just the build inputs for Wine in a local derivation**, rather than touching system-wide headers. You basically want a custom `linuxHeaders` derivation with your patch, and then feed that into a `wine-staging` build.

Here’s the approach step by step.

---

## 1. Create a patched `linuxHeaders` derivation

Nixpkgs already provides `linuxHeaders`. You can override it with your patch:

```nix
# patched-headers.nix
{ pkgs }:

pkgs.linuxHeaders.overrideAttrs (old: {
  patches = (old.patches or []) ++ [
    (pkgs.writeText "input-key-max.patch" ''
      diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
      index 8d764aab29de..35eb59ae1f19 100644
      --- a/include/linux/mod_devicetable.h
      +++ b/include/linux/mod_devicetable.h
      @@ -311,7 +311,7 @@ struct pcmcia_device_id {
       #define INPUT_DEVICE_ID_EV_MAX			0x1f
       #define INPUT_DEVICE_ID_KEY_MIN_INTERESTING	0x71
      -#define INPUT_DEVICE_ID_KEY_MAX		0x2ff
      +#define INPUT_DEVICE_ID_KEY_MAX		0x4ff
       #define INPUT_DEVICE_ID_REL_MAX		0x0f
       #define INPUT_DEVICE_ID_ABS_MAX		0x3f
       #define INPUT_DEVICE_ID_MSC_MAX		0x07
      diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
      index b6a835d37826..ad1b9bed3828 100644
      --- a/include/uapi/linux/input-event-codes.h
      +++ b/include/uapi/linux/input-event-codes.h
      @@ -774,7 +774,7 @@
       #define KEY_MIN_INTERESTING	KEY_MUTE
      -#define KEY_MAX			0x2ff
      +#define KEY_MAX			0x4ff
       #define KEY_CNT			(KEY_MAX+1)
    '')
  ];
})
```

---

## 2. Override `wine-staging` to use those headers

Now create a custom Wine build that uses your patched headers:

```nix
# wine-custom.nix
{ pkgs }:

let
  patchedHeaders = import ./patched-headers.nix { inherit pkgs; };
in
pkgs.wineWowPackages.staging.overrideAttrs (old: {
  buildInputs = (old.buildInputs or []) ++ [ patchedHeaders ];
  nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ patchedHeaders ];

  # Ensure Wine actually picks them up first
  NIX_CFLAGS_COMPILE = (old.NIX_CFLAGS_COMPILE or "") + " -I${patchedHeaders}/include";
})
```

---

## 3. Build it (standalone, no system override)

You can build it directly:

```bash
nix build -f wine-custom.nix
```

Or with flakes:

```nix
# flake.nix
{
  description = "Wine with patched linux headers";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.wine-custom =
      import ./wine-custom.nix { inherit pkgs; };
  };
}
```

Then:

```bash
nix build .#wine-custom
```

---

## 4. Use it

Result will be in:

```
./result/bin/wine
```

This is fully standalone and does **not affect system packages**.

---

## Key Notes

* `linuxHeaders` is what Wine uses for userspace ABI (not your running kernel), so this works cleanly.
* Injecting headers via `NIX_CFLAGS_COMPILE` ensures your patched version wins.
* No need to override `stdenv` or global config.

---

## If it doesn’t pick up the headers

Wine’s build system can be stubborn. If needed, force it harder:

```nix
configureFlags = (old.configureFlags or []) ++ [
  "CPPFLAGS=-I${patchedHeaders}/include"
];
```

---

## Optional: dev shell

If you want to experiment interactively:

```nix
pkgs.mkShell {
  buildInputs = [ patchedHeaders pkgs.wineWowPackages.staging ];
}
```

---

If you want, I can also show a version that:

* builds only 64-bit Wine (faster), or
* injects patches directly into Wine instead of headers (sometimes cleaner depending on why you need `KEY_MAX=0x4ff`).

*/