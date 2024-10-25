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
