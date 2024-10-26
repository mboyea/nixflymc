{ pkgs, image, name, version ? "latest" } : pkgs.writeShellApplication {
  name = "${name}-${version}";
  runtimeInputs = [
    image
    pkgs.docker
    pkgs.skopeo
    pkgs.flyctl
  ];
  text = ''
    echo "I should deploy the app!"
    exit 0
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
