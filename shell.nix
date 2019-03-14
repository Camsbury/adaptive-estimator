let
  nixPinned = import (builtins.fetchTarball  "https://github.com/NixOS/nixpkgs/archive/fa82ebccf66.tar.gz") {};
in
  { nixpkgs ? nixPinned }:
    let
      adaptive-estimator = (import ./default.nix { inherit nixpkgs; });
      adaptive-estimatorShell = with nixpkgs;
      haskell.lib.overrideCabal adaptive-estimator (oldAttrs: {
        librarySystemDepends = with pkgs; [
          cabal-install
          haskellPackages.ghcid
          sourceHighlight
        ];
      });
    in
      adaptive-estimatorShell.env
