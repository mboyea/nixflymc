{ dockerTools, name, version, packages, lib }: dockerTools.streamLayeredImage {
  name = "${name}-server-image";
  tag = "${version}";
  contents = [ packages.server ];
  config = {
    Cmd = [ "${lib.getExe packages.server}" ];
    ExposedPorts = {
      "25565/tcp" = {};
    };
  };
}

