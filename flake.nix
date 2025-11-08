{
  description = "My nix flake templates";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs: {
    templates = {
      default = {
        path = ./default;
        description = "Simple default nix flake template";
      };
      cpp = {
        path = ./cpp;
        description = "Simple cpp nix flake template";
      };
      rust = {
        path = ./rust;
        description = "Simple rust nix flake template";
      };
      ocaml = {
        path = ./ocaml;
        description = "Simple ocaml nix flake template";
      };
    };
  };
}
