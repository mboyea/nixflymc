{ dockerTools, name, version }: dockerTools.buildLayeredImage {
  inherit name version;
  contents = [ packages.server ];
  config = {
    Cmd = [ apps.server.program ];
    ExposedPorts = {
      "25565/tcp" = {};
    };
  };
};

