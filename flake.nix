{
  description = "coco-system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/nur";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nur,
    nixpkgs-unstable,
    nixos-hardware,
    spicetify-nix,
    ...
  }: let
    inherit (nixpkgs) lib;
    systemSettings = {
      hostname = "laptop";
      timeZone = "Asia/Kolkata";
      locale = "en_US.UTF-8";
    };

    userSettings = {
      username = "coco"; # username
      name = "sachin chaudhary";
      hostname = "laptop";
    };

    unstable-packages = final: _prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit (final) system;
        config.allowUnfree = true;
      };
    };

    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    neovim = pkgs.callPackage ./nvim/neovim.nix {};
  in {
    packages.${system} = {
      inherit neovim;
    };

    nixosConfigurations = {
      ${systemSettings.hostname} = lib.nixosSystem {
        specialArgs = {
          inherit inputs userSettings systemSettings;
        };

        modules = [
          nixos-hardware.nixosModules.lenovo-ideapad-15alc6
          ./configuration.nix
          ({pkgs, ...}: {
            environment.systemPackages = [
              self.packages.${system}.neovim
            ];
          })
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [
              nur.overlays.default
              unstable-packages
            ];

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs userSettings;
              };
              users.${userSettings.username} = {
                imports = [
                  ./home-manager.nix
                  inputs.nur.modules.homeManager.default
                  ./modules/gui/spicetify.nix
                ];
              };
            };
          }
        ];
      };
    };
    devShells = {
      x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
        buildInputs = with nixpkgs.legacyPackages.x86_64-linux; [nil];

        shellHook = ''
          echo "Development shell ready for nix to configure"
        '';
      };
    };
  };
}
