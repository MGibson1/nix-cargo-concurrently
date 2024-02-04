{
  description = "Flake providing rust concurrently";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # We want to use packages from the binary cache
    flake-utils.url = "github:numtide/flake-utils";
    gitignore = { url = "github:hercules-ci/gitignore.nix"; flake = false; };
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
    {
      overlays.default = (final: prev: { inherit (self.packages.${final.system}) concurrently; });
    } // flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        concurrently = pkgs.callPackage ./concurrently.nix { inherit pkgs; };
      in
      rec {
        packages = {
          inherit concurrently;
          default = concurrently;
        };

        devShell = pkgs.mkShell {
          CARGO_INSTALL_ROOT = "${toString ./.}/.cargo";
        };
      });
}
