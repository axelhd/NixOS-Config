{
  config,
  pkgs,
  inputs,
  ...
}:
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    #theme = "astronaut";
  };

}
