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
      i = "0.0.0.0"; # only listen locally (nginx will proxy)
      p = [
        3210
      ];
    };
    volumes = {
      "/" = {
        path = "/home/ahd/copyparty/";
        access = {
          r = [ "*" ];
          w = [ "*" ];
        };
      };
    };
  };
}
