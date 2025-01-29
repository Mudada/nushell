{
  description = "Base";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable" ;
  };

  outputs = { self, nixpkgs }:

    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      manifest = (pkgs.lib.importTOML ./Cargo.toml).package;
    in 
    {
      packages.${system}.default = pkgs.rustPlatform.buildRustPackage {
	pname = manifest.name;
    	version = manifest.version;
    	cargoLock.lockFile = ./Cargo.lock;
	buildInputs = [
	  pkgs.curl
	  pkgs.openssl
	];
	doCheck = false;
    	src = ./.;
	meta = {
	  description = "nushell gang gang";
	  mainProgram = "nu";
	};
      };
    };
}
