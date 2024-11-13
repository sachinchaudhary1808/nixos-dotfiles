{
  description = "coco-system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    cachix.url = "github:cachix/cachix";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/nur";
    nix-colors.url = "github:misterio77/nix-colors";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  };

  outputs = inputs@{ self, nixpkgs, home-manager, nur, cachix, nixpkgs-unstable
    , nixos-hardware, spicetify-nix, ... }:

    let
      inherit (nixpkgs) lib;
      systemSettings = {
        hostname = "nixos";
        timeZone = "Asia/Kolkata";
        locale = "en_US.UTF-8";
      };
      userSettings = {
        username = "coco"; # username
        name = "sachin chaudhary";
        hostname = "nixos";
      };

      unstable-packages = final: _prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (final) system;
          config.allowUnfree = true;
        };
      };
      # pkgs = nixpkgs-unstable.legacyPackages."${system}";
      # config = { allowunfree = true; };
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      myNeovim = pkgs.callPackage ./nvim/neovim.nix { };
    in {
      packages.${system} = { neovim = myNeovim; };
      nixosConfigurations = {
        ${systemSettings.hostname} = lib.nixosSystem {

          specialArgs = { inherit inputs userSettings systemSettings; };

          modules = [
            nixos-hardware.nixosModules.lenovo-ideapad-15alc6
            ./configuration.nix
            ({ pkgs, ... }: {
              environment.systemPackages = [ self.packages.${system}.neovim ];
            })
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = [
                nur.overlay
                inputs.neorg-overlay.overlays.default
                unstable-packages
              ];

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs;
                  inherit userSettings;
                };
                users.${userSettings.username} = {
                  imports = [
                    ./home-manager.nix
                    inputs.nix-colors.homeManagerModules.default
                    inputs.nur.hmModules.nur
                    # inputs.spicetify-nix.homeManagerModules.default
                    ./modules/gui/spicetify.nix

                  ];
                };
              };
            }
          ];
        };
      };
    };
}
