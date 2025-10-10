{
  description = "A simple cpp template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.default = pkgs.mkShell {
        name = "devShell";

        buildInputs = with pkgs; [
          gcc
          gnumake

          gtest
        ];

        shellHook = ''
          export BUILD_DIR=./build
        '';
      };
    });
}
