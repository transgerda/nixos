{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";	
	};

	outputs = inputs@{
		self,
		nixpkgs,
	}:{
		nixosConfigurations.bamilaptop = nixpkgs.lib.nixosSystem rec {
			system = "x86_64-linux";
			specialArgs = {
				inherit inputs;
			};
			modules = [
				./configuration.nix
				./hardware-configuration.nix
			];
		};
		nixosConfigurations.werk = nixpkgs.lib.nixosSystem rec {
			system = "x86_64-linux";
			specialArgs = {
				inherit inputs;
			};
			modules = [
				./configuration-werk.nix
				./hardware-labels.nix
			];
		};
	};
}
