{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      opener.edit = [
        {
          run = "nvim \"$@\"";
          block = true;
        }
      ];
    };

    plugins = {
      move-symlink = ./move-symlink;
    };

    keymap = {
      manager.prepend_keymap = [
        {
          on = "W";
          run = "plugin move-symlink";
          desc = "Move here and symlink original location";
        }
      ];
    };
    initLua = ./yazi-init.lua;
  };
}
