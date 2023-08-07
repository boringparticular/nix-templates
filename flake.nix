{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: {
templates = {
    python = {
        path = ./python;
    };
};
  };
}
