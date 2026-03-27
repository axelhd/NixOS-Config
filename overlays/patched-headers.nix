{ pkgs }:

pkgs.linuxHeaders.overrideAttrs (old: {
  patches = (old.patches or []) ++ [
    /*
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
      */
    ./input-key-max.patch
  ];
})