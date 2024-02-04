{ pkgs ? import <nixpkgs> { }
, stdenv ? pkgs.stdenv
, lib ? stdenv.lib
, rustPlatform ? pkgs.rustPlatform
, fetchFromGitHub ? pkgs.fetchFromGitHub
}:
rustPlatform.buildRustPackage rec {
  pname = "concurrently";
  version = "0.3.3";

  src = fetchFromGitHub {
    owner = "tqwewe";
    repo = "concurrently";
    rev = "${version}";
    hash = "sha256-XUcnSuWAbi8mWL2gAdfdUs74dt5BDY/RJgPlpJ+KQC4=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = { };
  };

  meta = with lib; {
    description = "A utility for executing multiple commands concurrently";
    homepage = "https://github.com/tqwewe/concurrently";
    changelog = "https://github.com/tqwewe/concurrently/blob/v${version}/CHANGELOG.md";
    maintainers = with maintainers; [ tqwewe ];
  };
}
