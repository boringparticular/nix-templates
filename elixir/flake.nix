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
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        packages.default = pkgs.hello;

        devShells.default = pkgs.mkShell {
          packages = let
            elixir =
              pkgs.elixir.override
              {
                version = "1.18.0";
                sha256 = "fT3J8h2uuJ+dSR58kwlUkN023yFlmTwq2/O12KbjJc4=";
              };
          in
            with pkgs; [
              elixir
              elixir-ls
              next-ls
              protobuf
              protoc-gen-elixir
              erlang
            ];
        };
      };
      flake = {
      };
    };
}
