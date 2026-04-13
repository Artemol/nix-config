{
  description = "My Nix flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    home-manager-darwin.url = "github:nix-community/home-manager";
    home-manager-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, home-manager-darwin, nix-darwin, ... }:
  {
    # NixOS configurations
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager
          ./hosts/wsl.nix
        ];
      };
    };

    darwinConfigurations = {
      suika = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/suika.nix
          home-manager-darwin.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.toku163.imports = [
              ./home/common.nix
              ./home/suika.nix
            ];

            system.configurationRevision = self.rev or self.dirtyRev or null;
          }
        ];
      };

      bergamot = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/bergamot.nix
          home-manager-darwin.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.toku163.imports = [
              ./home/common.nix
              ./home/bergamot.nix
            ];

            system.configurationRevision = self.rev or self.dirtyRev or null;
          }
        ];
      };
    };

    # non-NixOS configurations
    homeConfigurations = {
      # x86_64 Linux laptop
      linux = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        modules = [ ./home/common.nix ./home/linux.nix ];
      };
    };
  };
}
