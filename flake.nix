{
  description = "NixOS flake";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    everforest.url = "git+https://codeberg.org/fwinter/everforest-nix.git";

    #nvchad-config = {
    #url = "path:/home/ahd/nvchad-config"; # <- for local relative folder (e.g. path:./home/nvim)
    #flake = false;
    #};

    # Not used, switched to nvf
    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      #UNCOMMENT ME inputs.nixpkgs.follows = "nvchad-config";
    };

    # Obsidian nvim not used
    #obsidian-nvim.url = "github:epwalsh/obsidian.nvim";

    nvf = {
      url = "github:notashelf/nvf";
      # You can override the input nixpkgs to follow your system's
      # instance of nixpkgs. This is safe to do as nvf does not depend
      # on a binary cache.
      inputs.nixpkgs.follows = "nixpkgs";
      # Optionally, you can also override individual plugins
      # for example:
      #inputs.obsidian-nvim.follows = "obsidian-nvim"; # <- this will use the obsidian-nvim from your inputs
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    rednix = {
      url = "github:redcode-labs/RedNix";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    pwndbg.url = "github:pwndbg/pwndbg";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    copyparty.url = "github:9001/copyparty";

  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      catppuccin,
      everforest,
      nvf,
      pwndbg,
      stylix,
      copyparty,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      extraSpecialArgs = {
        inherit system;
        inherit inputs;
      }; # <- passing inputs to the attribute set for home-manager
      specialArgs = {
        inherit system;
        inherit inputs;
      }; # <- passing inputs to the attribute set for NixOS (optional)
    in
    {
      # Please replace my-nixos with your hostname
      nixosConfigurations = {
        cesar = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            # Import the previous configuration.nix we used,
            # so the old configuration file still takes effect
            ./host/cesar/configuration.nix
            catppuccin.nixosModules.catppuccin
            everforest.nixosModules.everforest
            stylix.nixosModules.stylix
            copyparty.nixosModules.default
            (
              { pkgs, ... }:
              {
                # add the copyparty overlay to expose the package to the module
                nixpkgs.overlays = [ copyparty.overlays.default ];
                # (optional) install the package globally
                environment.systemPackages = [ pkgs.copyparty ];
              }
            )
            #nvf.nixosModules.default
            #./immich.nix

            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                inherit extraSpecialArgs;
                useGlobalPkgs = true;
                useUserPackages = true;
                users.ahd = import ./home;
              };
            }
          ];
        };
        kali = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            # Import the previous configuration.nix we used,
            # so the old configuration file still takes effect
            ./host/kali/configuration.nix
            catppuccin.nixosModules.catppuccin
            everforest.nixosModules.everforest
            stylix.nixosModules.stylix
            copyparty.nixosModules.default
            #nvf.nixosModules.default
            #./immich.nix

            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                inherit extraSpecialArgs;
                useGlobalPkgs = true;
                useUserPackages = true;
                users.ahd = import ./home;
              };
            }
          ];
        };

      };
      "ahd@cesar" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          nvf.homeManagerModules.default # <- this imports the home-manager module that provides the options
          #./home # <- your home entrypoint, `programs.nvf.*` may be defined here
          stylix.homeModules.stylix
        ];
      };
      "ahd@kali" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          nvf.homeManagerModules.default # <- this imports the home-manager module that provides the options
          #./home # <- your home entrypoint, `programs.nvf.*` may be defined here
          stylix.homeModules.stylix
        ];
      };

    };

}
