{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.username = "ahd";
  home.homeDirectory = "/home/ahd";

  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
  imports = [
    #inputs.rednix.container
    #inputs.everforest.homeModules.everforest
    inputs.nvf.homeManagerModules.default
    ./nvf.nix
    ./nvchad.nix # Disabled
    ./programs
    #    ./unstable-programs.nix
    ./terminal.nix
    ./hollywood.nix
    #./pwndbg.nix
    #inputs.pwndbg
    ./stylix.nix
    ./yazi.nix
    ./xdg.nix
  ];


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "25.05";
  home.stateVersion = "26.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
