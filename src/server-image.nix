{ lib, pkgs, name, version, packages }: let
  base = pkgs.dockerTools.pullImage {
    # to get variables to update base image:
    # https://hub.docker.com/_/busybox/tags
    # nix develop
    # nix-prefetch-docker --quiet --image-name busybox --image-tag 1.37.0 --image-digest sha256:bd39d7ac3f02301aec35d27a633d643770c0c4073c5b8cb588b1680c4f1e84e5
    imageName = "busybox";
    imageDigest ="sha256:bd39d7ac3f02301aec35d27a633d643770c0c4073c5b8cb588b1680c4f1e84e5";
    finalImageName = "busybox";
    finalImageTag = "1.37.0";
    sha256 = "1rwnka21y7rj8jz250ay7c6mmyja7nngl0ia1z64rbcxq4ylgdvi";
    os = "linux";
    arch = "amd64";
  };
in pkgs.dockerTools.streamLayeredImage {
  name = "${name}-server-image";
  tag = "${version}";
  fromImage = base;
  contents = [
    packages.server
    pkgs.screen
  ];
  config = {
    Cmd = [ "${lib.getExe packages.server}" ];
    ExposedPorts = {
      "25565/tcp" = {};
    };
  };
}

