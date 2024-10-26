---
title: nixflymc
author: [Matthew T. C. Boyea]
lang: en
subject: server
keywords: [linux, nixos, nix, docker, fly, server, minecraft]
default_: report
---
## Minecraft server to be hosted by fly.io using a Nix Docker container

This project is not yet complete. No documentation is available.

### TODO

- Make `nix fun .#deploy` push the software to fly.io
- Make GitHub Actions trigger the build process when you push to main branch
- Configure nixflymc.nix to require https://github.com/Infinidoge/nix-minecraft
- Configure nixflymc.nix to start a minecraft server
- Test that Minecraft works
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


#### 


### Contribute

Unfortunately, this project doesn't support community contributions right now. Feel free to fork, but be sure to [read the license](./LICENSE.md).

