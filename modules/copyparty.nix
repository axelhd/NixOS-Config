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
      i = "127.0.0.1"; # only listen locally (nginx will proxy)
      p = [
        3210
      ];
      #no_anon = true;
    };
    accounts = {
      htx = {
        passwordFile = "/var/lib/secrets/copypartyHtxPassword";
      };
    };
    volumes = {
      "/" = {
        path = "/home/copyparty/copyparty/htx/";
        access = {
          r = [ "htx" ];
          w = [ "htx" ];
        };
      };
    };
  };

  services.nginx.virtualHosts = {
    "drive.${config.networking.domain}" = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:3210";
        proxyWebsockets = true;
        extraConfig = ''
          client_max_body_size 0;
        '';
      };
    };
  };
}
