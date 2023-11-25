{
  description = "A very basic flake";

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    packages.${system}.project = pkgs.buildGoModule rec {
      pname = "vid";
      version = "0.0.1";
      src = ./.;
      vendorHash = null;
    };
    packages.${system}.default = self.packages.${system}.project;
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        go
        gopls
        gotools
        go-tools
        golangci-lint
        gofumpt
      ];
    };
  };
}
