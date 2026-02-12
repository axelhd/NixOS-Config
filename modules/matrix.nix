# Before instalation
# $ sudo -u postgres psql
# postgres=# CREATE ROLE "matrix-synapse" WITH LOGIN;
# CREATE ROLE
# postgres=# CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
#   TEMPLATE template0
#   LC_COLLATE = 'C'
#   LC_CTYPE = 'C';
# CREATE DATABASE

{
  pkgs,
  lib,
  config,
  ...
}:
let
  fqdn = "${config.networking.hostName}.${config.networking.domain}";
  baseUrl = "https://${config.networking.domain}";
  clientConfig."m.homeserver".base_url = baseUrl;
  serverConfig."m.server" = "${fqdn}:443";
  mkWellKnown = data: ''
    default_type application/json;
    add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
  '';
in
{
  #networking.hostName = "matrix";
  networking.domain = "axessible.dev";
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.postgresql.enable = true;

  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    virtualHosts = {
      # If the A and AAAA DNS records on example.org do not point on the same host as the
      # records for myhostname.example.org, you can easily move the /.well-known
      # virtualHost section of the code to the host that is serving example.org, while
      # the rest stays on myhostname.example.org with no other changes required.
      # This pattern also allows to seamlessly move the homeserver from
      # myhostname.example.org to myotherhost.example.org by only changing the
      # /.well-known redirection target.
      "${config.networking.domain}" = {
        enableACME = true;
        forceSSL = true;
        # This section is not needed if the server_name of matrix-synapse is equal to
        # the domain (i.e. example.org from @foo:example.org) and the federation port
        # is 8448.
        # Further reference can be found in the docs about delegation under
        # https://element-hq.github.io/synapse/latest/delegate.html
        locations."= /.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
        # This is usually needed for homeserver discovery (from e.g. other Matrix clients).
        # Further reference can be found in the upstream docs at
        # https://spec.matrix.org/latest/client-server-api/#getwell-knownmatrixclient
        locations."= /.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;

        locations."/_matrix".proxyPass = "http://[::1]:8008";
        locations."/_synapse/client".proxyPass = "http://[::1]:8008";
        locations."/_synapse/admin/" = {
          proxyPass = "http://[::1]:8008";
          extraConfig = ''
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header Host $host;
          '';
        };
        locations."/" = {
          priority = 1000; # Lower priority to ensure other locations (e.g. /_matrix, /.well-known) win
          root = pkgs.synapse-admin;
          extraConfig = ''
            index index.html;
            try_files $uri $uri/ /index.html;
          '';
        };
      };
      "${fqdn}" = {
        enableACME = true;
        forceSSL = true;
        # It's also possible to do a redirect here or something else, this vhost is not
        # needed for Matrix. It's recommended though to *not put* element
        # here, see also the section about Element.
        # Forward all Matrix API calls to the synapse Matrix homeserver. A trailing slash
        # *must not* be used here.
        locations."/_matrix".proxyPass = "http://[::1]:8008";
        # Forward requests for e.g. SSO and password-resets.
        locations."/_synapse/client".proxyPass = "http://[::1]:8008";
        locations."/_synapse/admin/" = {
          proxyPass = "http://[::1]:8008";
          extraConfig = ''
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header Host $host;
          '';
        };
      };
      "element.${fqdn}" = {
        enableACME = true;
        forceSSL = true;
        serverAliases = [ "element.${config.networking.domain}" ];

        root = pkgs.element-web.override {
          conf = {
            default_server_config = clientConfig; # see `clientConfig` from the snippet above.
          };
        };
        "cinny.${fqdn}" = {
          enableACME = true;
          forceSSL = true;
          serverAliases = [ "cinny.${fqdn}" ];

          root = pkgs.cinny.override {
            conf = {
              defaultHomeserver = baseUrl;
            };
          };

          extraConfig = ''
            index index.html;
            try_files $uri $uri/ /index.html;
          '';
        };
      };
    };
  };

  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = config.networking.domain;
      # The public base URL value must match the `base_url` value set in `clientConfig` above.
      # The default value here is based on `server_name`, so if your `server_name` is different
      # from the value of `fqdn` above, you will likely run into some mismatched domain names
      # in client applications.
      public_baseurl = baseUrl;
      enable_registration = true;
      enable_registration_without_verification = true;

      admins = [ "@axe:axessible.dev" ];

      /* Get key
      sudo install -m 600 -o matrix-synapse -g matrix-synapse \
        <(openssl rand -hex 32) \
        /var/lib/matrix-synapse/macaroon.key
      */
      #macaroon_secret_key = lib.mkForce (builtins.readFile /var/lib/matrix-synapse/macaroon.key);

      listeners = [
        {
          port = 8008;
          bind_addresses = [ "127.0.0.1" "::1" ];
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [
            {
              names = [
                "client"
                "federation"
              ];
              compress = true;
            }
          ];
        }
      ];
    };
  };
}