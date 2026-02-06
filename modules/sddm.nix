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
    theme = "astronaut";
    extraPackages = [ pkgs.sddm-astronaut ];
  };

}
