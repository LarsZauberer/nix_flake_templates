{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.default = pkgs.mkShell {
        name = "devShell";

        buildInputs =
          (with pkgs; [
            ocaml
            ocamlformat
            dune_2
          ])
          ++ (with pkgs.ocamlPackages; [
            utop
            ocaml-lsp
          ]);
      };
    });
}
