{
  description = "A minecraft server in a Docker container to be hosted by Fly.io";
  # to update a dependency, use a new revision number
  # get new revision numbers using: git ls-remote https://github.com/<repo_path> | grep HEAD
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    utils.url = "github:numtide/flake-utils?rev=c1dfcf08411b08f6b8615f7d8971a2bfa81d5e8a";
  };
  outputs = { self, nixpkgs, utils, ... }: let
    name = "nixflymc";
    version = "0.0.0";
  in utils.lib.eachDefaultSystem (
    system: let
      pkgs = import nixpkgs { inherit system; };
    in rec {
      packages = {
        server = pkgs.callPackage ./src/server.nix {
          name = "${name}-server";
          inherit version;
        };
        deploy = pkgs.callPackage ./src/deploy.nix {
          name = "${name}-deploy";
          inherit version;
          image = dockerImages.default;
        };
        default = packages.server;
      };
      dockerImages = {
        server = pkgs.callPackage ./src/server-container.nix {
          name = "${name}-server-container";
          tag = "${version}";
          inherit packages apps;
        };
        default = dockerImages.server;
      };
      apps = {
        server = utils.lib.mkApp { drv = packages.server; };
        deploy = utils.lib.mkApp { drv = packages.deploy; };
        default = apps.server;
      };
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.docker
          pkgs.skopeo
          pkgs.flyctl
        ];
      };
    }
  );
}

