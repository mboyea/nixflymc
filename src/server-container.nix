{ dockerTools, name, tag, packages, apps }: dockerTools.buildLayeredImage {
  inherit name tag;
  contents = [ packages.server ];
  config = {
    Cmd = [ apps.server.program ];
    ExposedPorts = {
      "25565/tcp" = {};
    };
  };
}

