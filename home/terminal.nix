{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Axel Hajslund Damgaard";
    userEmail = "axel@hajslunddamgaard.dk";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = lib.mkForce (pkgs.lib.importTOML ./starship.toml); # {
    #      add_newline = false;
    #      aws.disabled = true;
    #      gcloud.disabled = true;
    #      line_break.disabled = true;
    #    };

    #    presets = [
    #      "catppuccin-powerline"
    #    ];

  };

  programs.fastfetch = {
    enable = true;
    settings = pkgs.lib.importJSON ./fastfetch.jsonc;
  };

  home.file.".config/fastfetch/nix.png".source = ./nix.png;

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        #normal.family = "Nerd Font Hack";
        #bold.family = "Nerd Font Hack";
        #italic.family = "Nerd Font Hack";
        #bold_italic.family = "Nerd Font Hack";
        #draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.zoxide.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      eval "$(zoxide init bash)"
      export SVN_EDITOR=nvim
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      gdb = "pwndbg";
    };
  };
  programs.nushell = {
    enable = true;
    # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
    #configFile.source = ./.../config.nu;
    # for editing directly to config.nu
    extraConfig = ''
      let carapace_completer = {|spans|
      carapace $spans.0 nushell ...$spans | from json
      }
      $env.config = {
       show_banner: false,
       completions: {
       case_sensitive: false # case-sensitive completions
       quick: true    # set to false to prevent auto-selecting completions
       partial: true    # set to false to prevent partial filling of the prompt
       algorithm: "fuzzy"    # prefix or fuzzy
       external: {
       # set to false to prevent nushell looking into $env.PATH to find more suggestions
           enable: true 
       # set to lower can improve completion performance at the cost of omitting some options
           max_results: 100 
           completer: $carapace_completer # check 'carapace_completer' 
         }
       }
      } 
      $env.PATH = ($env.PATH | 
      split row (char esep) |
      prepend /home/myuser/.apps |
      append /usr/bin/env
      )
    '';
    shellAliases = {
      ll = "ls -l";
      lla = "ls -la";
      gdb = "pwndbg";
    };
  };
  #carapace.enable = true;
  #carapace.enableNushellIntegration = true;

  home.packages = with pkgs; [
    carapace
  ];
}
