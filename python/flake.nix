{
  description = "Application packaged using poetry2nix";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.poetry2nix = {
    url = "github:nix-community/poetry2nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    poetry2nix,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      # see https://github.com/nix-community/poetry2nix/tree/master#api for more functions and examples.
      inherit (poetry2nix.legacyPackages.${system}) mkPoetryApplication;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages = {
        myapp = mkPoetryApplication {projectDir = self;};
        default = self.packages.${system}.myapp;
      };

      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          python311Packages.flask
          python311Packages.black
          python311Packages.flake8
          python311Packages.flake8-bugbear
          python311Packages.pylint
          python311Packages.isort
          python311Packages.mypy
          nodePackages.pyright
          poetry2nix.packages.${system}.poetry
        ];
      };
    });
}
