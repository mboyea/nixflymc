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
      pkgs = import nixpkgs {
        inherit system;
      };
    in rec {
      packages.${name} = pkgs.callPackage ./${name}.nix {};

      apps.deploy = utils.lib.mkApp {
        name = "deploy-${name}";
        drv = pkgs.writeShellScriptBin "deploy-${name}" ''
          set -euxo pipefail
          export PATH="${nixpkgs.lib.makeBinPath [ (pkgs.docker.override { clientOnly = true; }) pkgs.flyctl ]}:$PATH"
          archive=${self.defaultDockerContainer.x86_64-linux}
          config=fly.toml

          image=$(docker load < $archive | awk '{ print $3; }')
          flyctl deploy -c $config -i $image
        '';
      };

      apps.${name} = utils.lib.mkApp {
        inherit name;
        drv = packages.${name};
      };

      dockerContainers.${name} = pkgs.dockerTools.buildLayeredImage {
        name = "${name}-container";
        tag = "${version}";
        contents = [
          packages.${name}
        ];
        config = {
          Cmd = [ apps.${name}.program ];
          ExposedPorts = {
            "25565/tcp" = {};
          };
        };
      };

      defaultPackage = packages.${name};
      defaultApp = apps.${name};
      defaultDockerContainer = dockerContainers.${name};

      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.flyctl
        ];
      };
    }
  );
}

