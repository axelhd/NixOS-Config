{
  config,
  pkgs,
  inputs,
  ...
}:

{

  services.immich = {
    enable = true;
    port = 2283;
    host = "10.0.0.8";
    openFirewall = true;
    #mediaLocation = "/data/hdd1/ahd/Pictures/immich/";
    accelerationDevices = null;
  };

    # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/data/corvina_photo" = {
    device = "//10.0.0.50/users/ahd/photo";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "-o ro,x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };

  users.users.immich.extraGroups = [
    "video"
    "render"
  ];

}
