{ dockerTools, name, version, packages, apps }: dockerTools.streamLayeredImage {
  name = "${name}-server-image";
  tag = "${version}";
  contents = [ packages.server ];
  config = {
    Cmd = [ apps.server.program ];
    ExposedPorts = {
      "25565/tcp" = {};
    };
  };
}

