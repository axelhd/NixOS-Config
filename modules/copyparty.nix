{
  config,
  pkgs,
  inputs,
  ...
}:
{
  services.copyparty = {
    enable = true;
    user = "copyparty";
    group = "copyparty";
    settings = {
      i = "0.0.0.0";
      # use lists to set multiple values
      p = [
        3210
      ];
    };
    volumes = {
      "/" = {
        path = "/home/ahd/zomboid/";
        access = {
          r = "*";
        };
      };
    };
  };
}
