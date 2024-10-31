---
title: nixflymc
author: [Matthew T. C. Boyea]
lang: en
subject: server
keywords: [linux, nixos, nix, docker, fly, server, minecraft]
default_: report
---
## A Minecraft server to be hosted by fly.io using a Nix Docker container

This project is not yet complete. No documentation is available.

### TODO

- Make `nix run .#serverContainer` operate equivalent to `nix run .#server`
- Test server is accessible through fly.io host
- Test that the server actually shuts off after 60s
- Configure fly.io to maintain persitant storage in the minecraft worldfile directory

### References

#### CI/CD

- https://docs.docker.com/build/ci/github-actions/share-image-jobs/
- https://nix.dev/guides/recipes/continuous-integration-github-actions
- https://github.com/DeterminateSystems/magic-nix-cache-action

#### Nix

- https://discourse.nixos.org/t/advice-on-packaging-an-app-with-a-nix-flake-nix-run/19192

#### Misc

- https://github.com/LutrisEng/nix-fly-template
- https://www.youtube.com/watch?v=5XY3K8DH55M

### Scripts

| command | description |
|:--- |:--- |
| `nix run` | run the server |
| `nix run .#deploy` | deploy the server to fly.io |
| `nix build .#serverImage` | build the docker server image |

### Contribute

Unfortunately, this project doesn't support community contributions right now. Feel free to fork, but be sure to [read the license](./LICENSE.md).

