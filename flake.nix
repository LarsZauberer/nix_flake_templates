{
  description = "My nix flake templates";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = inputs: {
    templates = {
      cpp = {
        path = ./cpp;
        description = "Simple cpp nix flake template";
      };
    };
  };
}
