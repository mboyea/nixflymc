{ lib, pkgs, name, version, packages }: let
  os = pkgs.dockerTools.pullImage {
    imageName = "nixos/nix";
    imageDigest =
      "sha256:473a2b527958665554806aea24d0131bacec46d23af09fef4598eeab331850fa";
    finalImageName = "nix";
    finalImageTag = "2.11.1";
    sha256 = "sha256-qvhj+Hlmviz+KEBVmsyPIzTB3QlVAFzwAY1zDPIBGxc=";
    os = "linux";
    arch = "x86_64";
  };
in pkgs.dockerTools.streamLayeredImage {
  name = "${name}-server-image";
  tag = "${version}";
  # fromImage = os;
  # maxLayers = 125;
  contents = [
    packages.server
  ];
  config = {
    Cmd = [ "${lib.getExe packages.server}" ];
    ExposedPorts = {
      "25565/tcp" = {};
    };
  };
}

