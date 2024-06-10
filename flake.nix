{
  description = "coco-system";

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs.cachix.url = "github:cachix/cachix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/nur";

    nix-colors.url = "github:misterio77/nix-colors";
    stylix.url = "github:danth/stylix";
    xremap-flake.url = "github:xremap/nix-flake";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";

  };

  outputs =
    inputs@{ self, nixpkgs, home-manager, catppuccin, nur, cachix, ... }:
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

      # pkgs = nixpkgs.legacyPackages."${system}";

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
                [ nur.overlay inputs.neorg-overlay.overlays.default ];

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
