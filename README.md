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

### TOOD

- Make manual build process you can step through with nix build && nix run
- Make GitHub Actions trigger the build process when you push to main branch
- Configure nixflymc.nix to require https://github.com/Infinidoge/nix-minecraft
- Configure nixflymc.nix to start a minecraft server
- Test that Minecraft works
- Configure fly.io to maintain persitant storage in the minecraft worldfile directory

### Contribute

Unfortunately, this project doesn't support community contributions right now. Feel free to fork, but be sure to [read the license](./LICENSE.md).

