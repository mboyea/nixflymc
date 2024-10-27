{ pkgs, name, version ? "latest", image, flyConfig ? "fly.toml" } : pkgs.writeShellApplication {
  name = "${name}-${version}";
  runtimeInputs = [
    image
    flyConfig
    # ? pkgs.docker
    # ! export PATH="${nixpkgs.lib.makeBinPath [ (pkgs.docker.override { clientOnly = true; }) pkgs.flyctl ]}:$PATH"
    # ! archive=${self.defaultDockerContainer.x86_64-linux}
    # ! image=$(docker load < $archive | awk '{ print $3; }')
    pkgs.skopeo
    pkgs.flyctl
  ];
  text = ''
    #!/usr/bin/env bash

    echoerror() { echo "Error:" "$@" 1>&2; }

    load_env() {
      if [ -r .env ]; then
        set -a
        # shellcheck disable=SC1091
        source .env
        set +a
      fi
    }

    test_env() {
      while [[ $# -gt 0 ]]; do
        if [ -z "$1" ]; then
          echoerror The required environment variable "$1" is not defined
          exit 1
        fi
        shift
      done
    }

    update_docker_image() {
      # skopeo --insecure-policy copy "tarball:${image}" "docker://docker.io/$DOCKER_USERNAME/${name}:${version}"
      # skopeo --insecure-policy copy ":${image}" "docker://docker.io/$DOCKER_USERNAME/${name}:${version}"
      echo TODO: skopeo copy
    }

    deploy_to_fly() {
      # flyctl deploy -c ${flyConfig} -i ${image}
      echo TODO: fly deploy
    }

    load_env
    test_env DOCKER_USERNAME DOCKER_PASSWORD FLY_API_TOKEN
    update_docker_image
    deploy_to_fly
  '';
}

# { writeShellApplication, name ? "server", version } : writeShellApplication {
#   name = "${name}-${version}";
#   runtimeInputs = [];
#   text = ''
#     echo "Hello, you big bad world!"
#     exit 0
#   '';
# }

# { stdenv, name ? "server", version }: stdenv.mkDerivation {
      # apps.deploy = utils.lib.mkApp {
      #   name = "deploy-${name}";
      #   drv = pkgs.writeShellScriptBin "deploy-${name}" ''
      #     set -euxo pipefail
      #     export PATH="${nixpkgs.lib.makeBinPath [ (pkgs.docker.override { clientOnly = true; }) pkgs.flyctl ]}:$PATH"
      #     archive=${self.defaultDockerContainer.x86_64-linux}
      #     config=fly.toml

      #     image=$(docker load < $archive | awk '{ print $3; }')
      #     flyctl deploy -c $config -i $image
      #   '';
      # };


# name: Fly Deploy
# on:
#   push:
#     branches:
#       - main
# jobs:
#   build:
#     runs-on: ubuntu-latest
#     steps:
#       - uses: actions/checkout@v4
#       - uses: cachix/install-nix-action@v27
#         with:
#           nix_path: nixpkgs=channel:nixos-24.05-small
#           extra_nix_config: |
#             experimental-features = nix-command flakes
#       # - uses: actions/upload-artifact@v4
#       #   with: /tmp/latest-image
#       #     name: latestImage
#       #     path: /tmp/latestImage.tar
#       # - uses: cachix/cachix-action@v10
#       #   with:
#       #     name: flynixmc
#       #     authToken: ${{ secrets.CACHIX_AUTH_TOKEN }}
#       - uses: DeterminateSystems/magic-nix-cache-action@v8
#       - run: nix --log-format raw -L build .#defaultDockerContainer.x86_64-linux
#   deploy:
#     needs: build
#     runs-on: ubuntu-latest
#     steps:
#       - uses: actions/checkout@v4
#       - uses: cachix/install-nix-action@v27
#         with:
#           nix_path: nixpkgs=channel:nixos-24.05-small
#           extra_nix_config: |
#             experimental-features = nix-command flakes
#       # - uses: actions/download-artifact@v4
#       #   with:
#       #     name: latestImage
#       #     path: /tmp
#       # - uses: cachix/cachix-action@v10
#       #   with:
#       #     name: flynixmc
#       #     authToken: ${{ secrets.CACHIX_AUTH_TOKEN }}
#       - uses: DeterminateSystems/magic-nix-cache-action@v8
#       - run: nix --log-format raw -L run .#deploy
#         env:
#           FLY_API_TOKEN: ${{ secrets.FLY_API_TOKEN }}
