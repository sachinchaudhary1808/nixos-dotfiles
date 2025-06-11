{
  description = "coco-system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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
    nix-flatpak,
    # neorg-overlay,
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
    # pkgs = nixpkgs.legacyPackages.${system};
    pkgs = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

    # pkgs = import nixpkgs { inherit system; overlays = [ neorg-overlay.overlays.default ]; }
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
          {
            nixpkgs.overlays = [
              nur.overlays.default
              unstable-packages
            ];
          }
          nixos-hardware.nixosModules.lenovo-ideapad-15alc6
          nix-flatpak.nixosModules.nix-flatpak
          ./configuration.nix
          ({...}: {
            environment.systemPackages = [
              self.packages.${system}.neovim
            ];
          })
          home-manager.nixosModules.home-manager
          {
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
        buildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
          emmet-language-server
          nodejs # for emmet-language-server
        ];

        shellHook = ''
          echo "Development shell ready for nix to configure"
        '';
      };
    };
  };
}
