{
  description = "coco-system";

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

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
    xremap-flake.url = "github:xremap/nix-flake";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  };

  outputs = inputs@{ self, nixpkgs, home-manager, nur, cachix, nixpkgs-unstable
    , nixos-hardware, spicetify-nix, ... }:

    let
      system = "x86_64-linux";
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

    in {
      nixosConfigurations = {
        ${systemSettings.hostname} = lib.nixosSystem {

          specialArgs = { inherit inputs system userSettings systemSettings; };

          modules = [
            nixos-hardware.nixosModules.lenovo-ideapad-15alc6
            ./configuration.nix
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
