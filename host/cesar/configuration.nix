# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Include Home Manager module
    #(import "${home-manager}/nixos")
    #inputs.rednix.container
    ../../cachix.nix
    ../../modules/nvidia.nix
    #../../modules/synapse.nix
    ../../modules/configuration.nix
    ../../modules/copyparty.nix
  ];
  networking.hostName = "cesar"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  services.monado = {
    enable = true;
    defaultRuntime = true; # Register as default OpenXR runtime
  };

  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
