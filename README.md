---
title: nixflymc
author: [Matthew T. C. Boyea]
lang: en
subject: server
keywords: [linux, nixos, nix, docker, fly, server, minecraft]
default_: report
---
## A Minecraft server to be hosted by fly.io using a Nix Docker container

I wanted to host a minecraft server for some friends.

- It would be costly to keep my PC online 24/7.
- If the server grows, my PC will slow down.
- If I do anything significant with my PC, the server will slow down.
- When I have personal network outages, it would affect everyone on the server.
- My ISP doesn't want me hosting a public server.

But a Minecraft hosting provider would require me to lock in to a monthly payment plan, which seems excessive and is pretty expensive.

Fly.io is a general purpose server hosting provider that charges you only for the compute and storage that your server actually uses.

- They only charge you for compute and storage costs you actually use (if nobody is playing, it doesn't cost much to host).
- They don't charge you if your server costs less than $5/mo to host.
- Their [prices are very reasonable](https://fly.io/docs/about/pricing/).
- If your server gets big, you can scale up.
- If your server is empty for a month, you don't end up paying anything at all.

For example, in November 2025 I'm hosting a server for friends where:

> The dedicated IPv4 address is $2/mo
> The persist storage costs (probably a 4GB world file) are $0.15/GB/mo
> The compute costs (shared-cpu-2x - 4GB RAM) are $0.0297/hr
> 
> So with dedicated IPv4 ($2.00) and 4GB storage ($0.60) we would have to play the Minecraft server for more than 80 hours in a month before I'd even have to pay ($5.00) for hosting.

## You probably don't want to use this

I am manually packaging a Minecraft server into a distroless Docker image using Nix.
This is so I have complete control as a software engineer about the code that goes into the server.
If you don't know what that means, you don't want that.

There is a publicly maintained Docker image that is much easier to configure.
I highly recommend you [use that Docker image instead](https://github.com/itzg/docker-minecraft-server).
Reference [this example](https://github.com/yamatt/fly-minecraft-server) of its use with Fly.io to get started.

## How to get started?

- [Fork this repository](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo).
- [Clone *your forked repository*](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) from GitHub to your computer.
- Make an account for [fly.io](https://fly.io/dashboard). Link your payment method in the account.
- Make an account for [docker.io](https://hub.docker.com/).
- [Install the Nix package manager](https://nixos.org/download/).
- Open a terminal with access to Nix in your cloned repository folder.
- Run `nix develop` to open a shell with access to the development tools (like `flyctl`).
- Run `flyctl launch --no-deploy --name <minecraft-server>` where `<minecraft-server>` is the name of your minecraft server.
- Create and modify any settings you'd like to in the server config at `src/server.nix`.
  Probably you should update the whitelist.
- [Create a Fly Access Token](https://fly.io/docs/security/tokens/)
- Create a file `.env` with content:
  
  ```sh
  DOCKER_USERNAME="<your_docker_account_username>"
  DOCKER_PASSWORD="<your_docker_account_password>"
  FLY_DEPLOY_TOKEN="<your_fly_deploy_token>"
  ```
  
- Deploy the server using `nix run .#deploy`.

You may also want to allow GitHub Actions to make deployments.

- [Add those .env secrets to GitHub Actions](https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions).
- Now when you `git add .`, `git commit -m ""`, then `git push`, GitHub actions will automatically deploy the server for you.

You and your friends may be able to connect to the server using the public IPv6 address from Fly.
However, many consumer ISP networks do not support IPv6.

- [Test your IPv6 connectivity](https://ipv6-test.com/).
  If you or any of your friends don't have access to IPv6, you'll need to get a dedicated IPv4 address from Fly.
- Get a dedicated IPv4 address using `flyctl ips allocate-v4`.

If you still can't connect to the server, [check that the server is even accessible by the IP address](https://mcsrvstat.us/).

### Scripts

| command | description |
|:--- |:--- |
| `nix run` | run `nix run .#server` |
| `nix run .#server` | run the server locally (you can connect from your home address via your PC's ip address, or publicly if port forwarding is enabled on your router and not blocked by your ISP) |
| `nix run .#serverContainer` | run the server locally in a Docker container |
| `nix run .#deploy` | deploy the server to fly.io |

### Contribute

Unfortunately, this project doesn't support community contributions right now. Feel free to fork, but be sure to [read the license](./LICENSE.md).

