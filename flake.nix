{
  description = "syncthing-config-tool";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    {
      overlays = {
        default = import ./overlay.nix;
      };
    }
    // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          overlays = [ self.overlays.default ];
          inherit system;
        };
        env = pkgs.buildEnv {
          name = "env";
          paths = [
            pkgs.go
            pkgs.nixpkgs-fmt
          ];
        };
      in
      {
        apps.default = {
          type = "app";
          program = "${pkgs.syncthing-config-tool}/bin/syncthing-config-tool";
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            env
          ];

          shellHook = ''
            if [[ -n ''${IN_NIX_SHELL:-} || ''${DIRENV_IN_ENVRC:-} = 1 ]]; then
              # We know that PWD is always the current directory in these contexts
              export PROJECT_ROOT=$PWD
            elif [[ -z ''${PROJECT_ROOT:-} ]]; then
              echo "ERROR: please set the PROJECT_ROOT env var to point to the project root" >&2
              return 1
            fi

            ln -sfT ${env} "$PROJECT_ROOT/.venv"
          '';
        };
      }
    );
}
