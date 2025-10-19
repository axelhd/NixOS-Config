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
        3211
      ];
    };
    volumes = {
      "/" = {
        path = "/home/ahd/Music/cd/";
        access = {
          r = "*";
        };
      };
    };
  };
}
