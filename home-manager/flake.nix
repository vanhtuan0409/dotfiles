{
  description = "My home manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs: {
    homeConfigurations = {
      linux-dell = inputs.home-manager.lib.homeManagerConfiguration {
        configuration = { pkgs, ... }: {
          imports = [ ./homes/linux-dell.nix ];
        };
        system = "x86_64-linux";
        homeDirectory = "/home/tuan";
        username = "tuan";
      };
    };

    linux-dell = self.homeConfigurations.linux-dell.activationPackage;
  };
}
