{
  description = "coco-system";
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

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, catppuccin, nur
    , nix-doom-emacs, ... }:
    let
      system = "x86_64-linux";

      lib = nixpkgs.lib;

      pkgs = import nixpkgs {
        inherit system;
        pkgs = nixpkgs.legacyPackages."${system}";

        config = { allowunfree = true; };
      };

    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          specialArgs = { inherit inputs system; };

          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = [ nur.overlay ];
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.coco = {
                  imports = [
                    ./home-manager.nix
                    inputs.nix-colors.homeManagerModules.default
                    catppuccin.homeManagerModules.catppuccin
                    inputs.nur.hmModules.nur
                    nix-doom-emacs.hmModule

                  ];
                };
              };
            }
          ];
        };
      };
    };
}
