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
    settings.user.name = "Axel Hajslund Damgaard";
    settings.user.email = "axel@hajslunddamgaard.dk";

    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true; # enables commit.gpgSign = true
    };

    extraConfig = {
      gpg.format = "ssh";

      # Optional but very commonly wanted – sign tags too:
      tag.gpgSign = true;

      # Optional – only needed if you want local verification (git log --show-signature) to work without GitHub:
      # gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
    };
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

  programs.kitty = lib.mkForce {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      window_padding_width = 3;
      background_opacity = "0.7";
      background_blur = 10;
      symbol_map =
        let
          mappings = [
            "U+23FB-U+23FE"
            "U+2B58"
            "U+E200-U+E2A9"
            "U+E0A0-U+E0A3"
            "U+E0B0-U+E0BF"
            "U+E0C0-U+E0C8"
            "U+E0CC-U+E0CF"
            "U+E0D0-U+E0D2"
            "U+E0D4"
            "U+E700-U+E7C5"
            "U+F000-U+F2E0"
            "U+2665"
            "U+26A1"
            "U+F400-U+F4A8"
            "U+F67C"
            "U+E000-U+E00A"
            "U+F300-U+F313"
            "U+E5FA-U+E62B"
          ];
        in
        (builtins.concatStringsSep "," mappings) + " JetBrainsMono Nerd Font";
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
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
      rebuild = "nixos-rebuild switch --log-format internal-json -v o+e>| nom --json";
    };
  };
  #carapace.enable = true;
  #carapace.enableNushellIntegration = true;

  home.packages = with pkgs; [
    carapace
  ];
}
