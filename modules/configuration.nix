{
  config,
  pkgs,
  inputs,
  ...
}:
{
  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  #services.xserver.wacom.enable = true;

  imports = [
    #./virtualization.nix
    #./i2p.nix
    ./restic.nix
    ./sddm.nix
  ];

  nixpkgs.config.allowBroken = true;

  boot.kernel.sysctl."kernel.sysrq" = 502;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  #services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  specialisation.kde.configuration = {
    services.desktopManager.plasma6.enable = true;
  };

  programs.kdeconnect.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # Enable XWayland for compatibility
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "dk";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing.drivers = with pkgs; [
    hplip
    hplipWithPlugin
  ];

  services.udev.extraRules = ''
    # ZSA Moonlander Mark I
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3297", ATTRS{idProduct}=="1969", MODE="0666"
    # Flash mode
    SUBSYSTEM=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04d8", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0666"

    SUBSYSTEM=="input", MODE="0660", GROUP="input"
    SUBSYSTEM=="hidraw", MODE="0660", GROUP="input"
    KERNEL=="hidraw*", MODE="0660", GROUP="input"

  '';

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "vineyard";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.0. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "public" = {
        "path" = "/mnt/Shares/Public";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "username";
        "force group" = "groupname";
      };
      "private" = {
        "path" = "/mnt/Shares/Private";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "username";
        "force group" = "groupname";
      };
    };
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ahd = {
    isNormalUser = true;
    description = "Axel Hajslund Damgaard";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docekr"
      "dialout"
      "input"
      "hamachi"
    ];
    shell = pkgs.nushell;
    #packages = with pkgs; [
    #kdePackages.kate
    #thunderbird
    #];
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  security.polkit.enable = true;

  programs.steam.enable = true;

  services.flatpak.enable = true;

  # hosts
  #networking.hosts = {
  #  "5.9.5.74" = ["axel.hajslunddamgaard.dk"];
  #};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    sddm-astronaut
    wget
    cryptsetup
    # Hyprland-related utilities
    home-manager
    capitaine-cursors
    zip
    unzip
    catppuccin-cursors.mochaMauve
    catppuccin-cursors.mochaDark
    catppuccin-cursors.mochaBlue
    mc
    bluez
    bluez-tools
    ntfs3g
    gparted
    winetricks
    protontricks
    android-tools
    clang
    cifs-utils
    clang-tools
    xdg-desktop-portal-hyprland
    libva
    nv-codec-headers-12
    cudatoolkit
    cachix
    ninja
    pkg-config
    cairo
    cmake
    kdePackages.kwallet
    docker
    dconf # Required for GTK theme settings
    nushell
    chntpw
    dislocker
    z3
    python313Packages.z3-solver
    cutter
    pwntools
    python313Packages.pwntools
    scanmem
    pwndbg
    nix-output-monitor
    cloudflared
    keymapp

    # FHS
    (
      let
        base = pkgs.appimageTools.defaultFhsEnvArgs;
      in
      pkgs.buildFHSEnv (
        base
        // {
          # rename to buildFHSEnv
          name = "fhs";
          targetPkgs =
            pkgs:
            # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
            # lacking many basic packages needed by most software.
            # Therefore, we need to add them manually.
            #
            # pkgs.appimageTools provides basic packages required by most software.
            (base.targetPkgs pkgs)
            ++ (with pkgs; [
              pkg-config
              ncurses
              # Feel free to add more packages here if needed.
            ]);
          profile = "export FHS=1";
          runScript = "bash";
          extraOutputsToInstall = [ "dev" ];
        }
      )
    )
  ];

  security.pam.services.sddm.enableKwallet = true;

  virtualisation.docker = {
    enable = true;
  };

  # plocate
  services.locate = {
    enable = true;
    package = pkgs.plocate;
  };

  nixpkgs = {
    overlays = [
      (final: prev: {
        nvchad = inputs.nix4nvchad.packages."${pkgs.system}".nvchad;
        inherit (inputs.pwndbg.packages.${final.system}) pwndbg;
      })
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
  ];

  #programs.swall.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  networking.networkmanager.enable = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
