{
  config,
  pkgs,
  inputs,
  ...
}:
{
  networking.wireless = {
    enable = true;
    networks = {
      vineyard = {                # SSID with no spaces or special characters
        psk = "7ce8b0252482962fc4663bbd609163a9d2c42ce0c9141478c998a18c3238b1b7";
      };
      "echelon's AP" = {         # SSID with spaces and/or special characters
        psk = "ijklmnop";
      };
      echelon = {                # Hidden SSID
        hidden = true;
        psk = "qrstuvwx";
      };
      free.wifi = {};            # Public wireless network
  };
  }
}
