{
  config,
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    sddm-astronaut
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "astronaut";
    extraPackages = [ pkgs.sddm-astronaut ];
  };

}
