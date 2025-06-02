{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    systems = [
      "x86_64-linux"
    ];
    pkgsFor = lib.genAttrs systems (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    # forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    inherit lib;
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    # packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.alejandra);
    overlays = import ./overlays {inherit inputs outputs;};

    nixosConfigurations = {
      # desktop-nixos = lib.nixosSystem {
      #   specialArgs = {inherit inputs outputs;};
      #   modules = [
      #     ./nixos/configuration.nix
      #     home-manager.nixosModules.home-manager
      #     {
      #       home-manager.useGlobalPkgs = true;
      #       home-manager.useUserPackages = true;
      #       home-manager.users.cody = import ./home-manager/home.nix;
      #     }
      #   ];
      # };
      desktop = lib.nixosSystem {
        modules = [./hosts/desktop];
        specialArgs = {inherit inputs outputs;};
      };
    };

    homeConfigurations = {
      "cody@desktop" = lib.homeManagerConfiguration {
        modules = [./home/cody/desktop];
        extraSpecialArgs = {inherit inputs outputs;};
        pkgs = pkgsFor.x86_64-linux;
      };
    };
  };
}
