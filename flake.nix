{
  description = "A very basic flake";

  inputs = {
    official-templates.url = github:NixOS/templates;
  };

  outputs = {
    self,
    nixpkgs,
    official-templates,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    templates =
      {
        python = {
          path = ./python;
        };
        go = {
          path = ./go;
        };
      }
      // official-templates.templates;
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        alejandra
        nixd
      ];
    };
  };
}
