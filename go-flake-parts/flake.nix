{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
      ];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;

        packages.default = pkgs.buildGoModule {
          pname = "my-project";
          version = "0.1.0";
          src = ./.;
          ldFlags = [];
          vendorHash = pkgs.lib.fakeHash;
        };

        devShells.default = with pkgs;
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
      flake = {
      };
    };
}
