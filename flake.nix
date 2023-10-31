{
  description = "A very basic flake";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    templates = {
      python = {
        path = ./python;
      };
    };
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        alejandra
        nixd
      ];
    };
  };
}
