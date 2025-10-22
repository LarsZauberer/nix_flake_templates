{
  description = "A simple cpp template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      buildInputs = with pkgs; [
        gcc
        gnumake
        gtest
      ];
    in {
      packages.default = pkgs.stdenv.mkDerivation {
        pname = "mylib";
        version = "1.0.0";

        src = ./.;

        buildInputs = buildInputs;

        buildPhase = ''
          make all
        '';

        installPhase = ''
          mkdir -p $out/bin
          mkdir -p $out/lib
          mkdir -p $out/include

          # Install binaries
          cp bin/* $out/bin/

          # Install libraries
          cp lib/* $out/lib/

          # Install headers
          cp -r include/* $out/include/
        '';

        meta = {
          description = self.description;
          license = pkgs.lib.licenses.mit;
        };
      };

      devShells.default = pkgs.mkShell {
        name = "devShell";

        buildInputs = buildInputs;
      };
    });
}
