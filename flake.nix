{
  description = "The Sieve of Eratosthenes implemented in many different languages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        currentDir = builtins.readDir ./.;
        dirs = pkgs.lib.filterAttrs (_: v: v == "directory") currentDir;
      in {
        packages = builtins.mapAttrs (dir: _: pkgs.callPackage ./${dir} {}) dirs;
      }
    );
}
