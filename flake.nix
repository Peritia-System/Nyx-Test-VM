{
  description = "Main - Flake";

  ################################################################
  # 🔗 Inputs
  ################################################################
  inputs = {
    # Core NixOS packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nyx.url = "github:Peritia-System/Nyx-Tools/Beta-test";
    nyx.inputs.nixpkgs.follows = "nixpkgs";

    nixos95.url = "github:Peritia-System/NixOS-95/Beta-import";
    nixos95.inputs.nixpkgs.follows = "nixpkgs";
    #nixosModules.nixos95 = import ./nixos95;

  };

  ################################################################
  # 🚀 Outputs
  ################################################################
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    nyx,
    nixos95,
    ...
  }: {


    nixosConfigurations = {

      ############################################################
      # 💻 VM
      ############################################################
      Test-VM = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs self;
          host = "Test-VM";
        };
        modules = [
          ./Configurations/Hosts/Test-VM/configuration.nix
        ];
      };

    };
  };
}
