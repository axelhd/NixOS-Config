{
  config,
  pkgs,
  inputs,
  ...
}:
{
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [ "ahd" ];

  virtualisation.libvirtd.enable = true;
  users.extraGroups.vboxusers.members = [ "ahd" ];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;

  virtualisation.spiceUSBRedirection.enable = true;
}
