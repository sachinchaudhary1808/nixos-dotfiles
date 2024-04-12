{
  description = "nixos-system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nixvim
    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    pkgs = nixpkgs.legacyPackages."x86_64-linux";

      config = {
        allowtnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system;};

        modules = [
          ./configuration.nix
          # home-manager.nixosModules.home-manager
          # {
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;
          #   /*
          #   home-manager.users.coco = import ./nixos/home-manager.nix;
          #   */
          # }
          # inputs.nixvim.nixosModules.nixvim
         /*  ./nixos/nixvim.nix */
          /* inputs.nixvim.nixosModules.nixvim */
          # ./home-manager.nix
        ];
      };
    };
 homeConfigurations."coco" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home-manager.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
  };
}
