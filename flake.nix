{
  description = "A development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  # Flake outputs
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        # Development environment output
        devShell = pkgs.mkShell {
          # The Nix packages provided in the environment
          packages = with pkgs; [
            typst
            typst-lsp
            typst-fmt
          ];

          # Environment variables provided in the environment
          PROJECT = "typst-templates";

          # Hook commands to run in the environment
          shellHook = ''
            # Set flake root
            export FLAKE_ROOT="''$(git rev-parse --show-toplevel)"

            # Source project paths
            export PATH="$PATH:$FLAKE_ROOT/.bin"
          '';
        };
      }
    );
}
