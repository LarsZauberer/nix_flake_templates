{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        python-env = pkgs.python314.withPackages (
          ps: with ps; [
          ]
        );
      in
      {
        devShells.default = pkgs.mkShell {
          name = "devShell";

          buildInputs = [
            python-env
          ];

          shellHook = "";
        };
      }
    );
}
