{
  description = "A reproducible Rust application and library with strict quality checks";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      rust-overlay,
      ...
    }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ] (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
        };
        toolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
        rustPlatform = pkgs.makeRustPlatform {
          cargo = toolchain;
          rustc = toolchain;
        };
        manifest = builtins.fromTOML (builtins.readFile ./Cargo.toml);
        commonArgs = {
          pname = manifest.package.name;
          version = manifest.package.version;
          src = pkgs.lib.cleanSourceWith {
            src = ./.;
            filter =
              path: type:
              !(builtins.elem (builtins.baseNameOf path) [
                "target"
                ".direnv"
                "result"
              ])
              && pkgs.lib.cleanSourceFilter path type;
          };
          cargoLock.lockFile = ./Cargo.lock;
          cargoBuildFlags = [
            "--locked"
            "--workspace"
            "--all-features"
          ];
          cargoTestFlags = [
            "--locked"
            "--workspace"
            "--all-features"
          ];
        };
        package = rustPlatform.buildRustPackage (
          commonArgs
          // {
            doCheck = true;
            meta.mainProgram = manifest.package.name;
            meta.description = manifest.package.description;
          }
        );
      in
      {
        packages.default = package;
        apps.default = {
          type = "app";
          program = "${package}/bin/${manifest.package.name}";
          meta.description = manifest.package.description;
        };
        formatter = pkgs.nixfmt;

        checks.tests = package;
        checks.lint = rustPlatform.buildRustPackage (
          commonArgs
          // {
            pname = "${manifest.package.name}-lint";
            nativeBuildInputs = [
              pkgs.nixfmt
              pkgs.taplo
              pkgs.actionlint
            ];
            buildPhase = ''
              runHook preBuild
              cargo fmt --all -- --check
              cargo clippy --locked --offline --workspace --all-targets --all-features -- -D warnings
              cargo doc --locked --offline --workspace --all-features --no-deps
              nixfmt --check flake.nix
              taplo fmt --check
              actionlint .github/workflows/*.yml
              runHook postBuild
            '';
            doCheck = false;
            installPhase = "touch $out";
          }
        );

        devShells.default = pkgs.mkShell {
          name = "rust-dev";
          packages = [
            toolchain
            pkgs.git
            pkgs.pre-commit
            pkgs.nixfmt
            pkgs.taplo
            pkgs.actionlint
            pkgs.cargo-deny
          ];
          RUST_SRC_PATH = "${toolchain}/lib/rustlib/src/rust/library";
        };
      }
    );
}
