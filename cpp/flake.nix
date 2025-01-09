{
  description = "A simple cpp template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs: let
    foreachSystem = f: inputs.nixpkgs.lib.mapAttrs f inputs.nixpkgs.legacyPackages;

    pname = "";
    version = "1.0";
  in {
    packages = foreachSystem (system: pkgs: {
      ${pname} = pkgs.callPackage ./package.nix {inherit pkgs pname version;};

      default = inputs.self.packages.${system}.${pname};
    });

    devShells = foreachSystem (system: pkgs: {
      default = pkgs.callPackage ./package.nix {
        inherit (pkgs) mkShell;
        package = inputs.self.packages.${system}.${pname};
      };
    });
  };
}
