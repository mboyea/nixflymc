{ pkgs, name, version ? "latest", image, flyConfig ? "fly.toml" } : pkgs.writeShellApplication {
  name = "${name}-deploy-${version}";
  runtimeInputs = [
    image
    flyConfig
    pkgs.gzip
    pkgs.skopeo
    pkgs.flyctl
  ];
  text = ''
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
      ${image} | gzip --fast | skopeo --insecure-policy copy --dest-creds="$DOCKER_USERNAME:$DOCKER_PASSWORD" "docker-archive:/dev/stdin" "docker://docker.io/$DOCKER_USERNAME/${name}:${version}"
    }

    deploy_to_fly() {
      flyctl deploy -c ${flyConfig} -i "docker.io/$DOCKER_USERNAME/${name}:${version}"
    }

    load_env
    test_env DOCKER_USERNAME DOCKER_PASSWORD FLY_API_TOKEN
    update_docker_image
    deploy_to_fly
  '';
}

