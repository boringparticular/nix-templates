{
  description = "A very basic flake";

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    packages.${system} = rec {
      myproject = pkgs.buildGoModule {
        pname = "myproject";
        version = "0.1.0";
        src = ./.;
        vendorHash = null;
      };
      packages.${system}.default = myproject;
    };
    devShells.${system}.default = with pkgs;
      mkShell {
        packages = [
          gopls
          gotools
          go-tools
          golangci-lint
          gofumpt
        ];

        nativeBuildInputs = [
          go
        ];
      };
  };
}
