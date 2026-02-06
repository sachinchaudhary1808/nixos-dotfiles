{
  description = "coco-system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/master"; # master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixpkgs-unstable,
      nixos-hardware,
      nix-flatpak,
      ...
    }:
    let
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

      # unstable-packages = final: _prev: {
      #   unstable = import inputs.nixpkgs-unstable {
      #     inherit (final) system;
      #     config.allowUnfree = true;
      #   };
      # };
      pkgs-Unstable = import nixpkgs-unstable { inherit system; };
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        ${systemSettings.hostname} = lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              userSettings
              systemSettings
              pkgs-Unstable
              ;
          };

          modules = [
            nixos-hardware.nixosModules.lenovo-ideapad-15alc6
            nix-flatpak.nixosModules.nix-flatpak
            ./configuration.nix
            (
              { ... }:
              {
                environment.systemPackages = [ ];
                # nixpkgs.overlays = [
                #   unstable-packages
                # ];
              }
            )
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs userSettings pkgs-Unstable;
                };
                users.${userSettings.username} = {
                  imports = [
                    ./home-manager.nix
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
            vscode-langservers-extracted
            nodejs
            nixd
            nil
          ];
          shellHook = ''
            echo "Development shell ready for nix to configure"
          '';
        };
      };
    };
}
