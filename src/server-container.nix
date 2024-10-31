{ pkgs, name, version, image} : pkgs.writeShellApplication {
  name = "${name}-server-container-${version}";
  runtimeInputs = [
    image
    pkgs.podman
  ];
  text = ''
    #!/usr/bin/env bash

    run_docker_image() {
      podman run docker-archive:/dev/stdin
    }

    echo "Starting docker container..."
    run_docker_image
  '';
}

