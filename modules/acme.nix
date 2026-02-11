{
  pkgs,
  lib,
  config,
  ...
}:
{
  security.acme = { 
    acceptTerms = true;
    defaults.email = "axessible@duck.com";
  };
}