{
  description = "A minecraft server in a Docker container to be hosted by Fly.io";
  # to update a dependency, use a new revision number
  # get new revision numbers using: git ls-remote https://github.com/<repo_path> | grep HEAD
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    utils.url = "github:numtide/flake-utils";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };
  outputs = { self, nixpkgs, utils, nix-minecraft, ... }: let
    name = "nixflymc";
    version = "0.0.0";
  in utils.lib.eachDefaultSystem (
    system: let
      pkgs = import nixpkgs { inherit system; };
    in rec {
      packages = {
        server = nix-minecraft.packages.${system}.vanilla-server;
        # server = pkgs.callPackage ./src/server.nix {
        #   inherit name version system nix-minecraft;
        # };
        serverImage = pkgs.callPackage ./src/server-image.nix {
          inherit name version packages apps;
        };
        deploy = pkgs.callPackage ./src/deploy.nix {
          inherit name version;
          image = packages.serverImage;
          flyConfig = "./fly.toml";
        };
        default = packages.server;
      };
      apps = {
        server = utils.lib.mkApp { drv = packages.server; };
        deploy = utils.lib.mkApp { drv = packages.deploy; };
        default = apps.server;
      };
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.podman
          pkgs.skopeo
          pkgs.flyctl
        ];
      };
    }
  );
}

