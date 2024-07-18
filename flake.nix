{
  description = "coco-system";

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    cachix.url = "github:cachix/cachix";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
    nur.url = "github:nix-community/nur";
    nix-colors.url = "github:misterio77/nix-colors";
    stylix.url = "github:danth/stylix";
    xremap-flake.url = "github:xremap/nix-flake";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";

  };

  outputs =
    inputs@{ self, nixpkgs, home-manager, catppuccin, nur, cachix, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

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
      system = final.system;
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
            ./configuration.nix
            home-manager.nixosModules.home-manager
            # inputs.stylix.nixosModules.stylix
            {
              nixpkgs.overlays =
                [ nur.overlay inputs.neorg-overlay.overlays.default unstable-packages];

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
                    catppuccin.homeManagerModules.catppuccin
                    inputs.nur.hmModules.nur

                  ];
                };
              };
            }
          ];
        };
      };
    };
}
