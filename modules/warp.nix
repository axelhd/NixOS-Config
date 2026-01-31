{ config, pkgs, ... }:

{
  # Enable the Cloudflare WARP service
  services.cloudflare-warp.enable = true;
}
