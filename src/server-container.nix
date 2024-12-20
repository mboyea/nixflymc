{ pkgs, name, version, image} : pkgs.writeShellApplication {
  name = "${name}-server-container-${version}";
  runtimeInputs = [
    image
    pkgs.podman
  ];
  text = ''
    ${image} | podman image load
    podman container run --tty --publish 25565:25565 localhost/${name}-server-image:${version}
  '';
}

