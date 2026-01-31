{
  config,
  pkgs,
  inputs,
  ...
}:
{
  containers.i2pd-container = {
    autoStart = true;
    config =
      { ... }:
      {

        system.stateVersion = "25.11"; # If you don't add a state version, nix will complain at every rebuild
        # Exposing the nessecary ports in order to interact with i2p from outside the container
        networking.firewall.allowedTCPPorts = [
          7070 # default web interface port
          4447 # default socks proxy port
          4444 # default http proxy port
          7656 # for XD
        ];

        services.i2pd.proto.sam.enable = true;

        services.i2pd = {
          enable = true;
          address = "127.0.0.1"; # you may want to set this to 0.0.0.0 if you are planning to use an ssh tunnel
          proto = {
            http.enable = true;
            socksProxy.enable = true;
            httpProxy.enable = true;
            i2cp.enable = true;
            i2pControl.enable = true;
          };
        };
      };
  };

  environment.systemPackages = [
    pkgs.mullvad-browser
    pkgs.xd
  ];
}
