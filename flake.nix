{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    niri-flake.url = "github:sodiboo/niri-flake";

    noctalia = {
      url = "github:noctalia-dev/noctalia";
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
  in {
    inherit lib;
    # nixosModules = import ./modules/nixos;
    # homeManagerModules = import ./modules/home;

    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.alejandra);
    overlays = import ./overlays {inherit inputs outputs;};

    nixosConfigurations = {
      lindon = lib.nixosSystem {
        modules = [./hosts/lindon];
        specialArgs = {inherit inputs outputs;};
      };

      yerin = lib.nixosSystem {
        modules = [./hosts/yerin];
        specialArgs = {inherit inputs outputs;};
      };
    };

    homeConfigurations = {
      "cody" = lib.homeManagerConfiguration {
        modules = [./users/cody];
        extraSpecialArgs = {inherit inputs outputs;};
        pkgs = pkgsFor.x86_64-linux;
      };
    };
  };
}
