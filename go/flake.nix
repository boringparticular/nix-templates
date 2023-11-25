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
    packages.${system}.myproject = pkgs.buildGoModule rec {
      pname = "myproject";
      version = "0.1.0";
      src = ./.;
      vendorHash = null;
    };
    packages.${system}.default = self.packages.${system}.myproject;
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
