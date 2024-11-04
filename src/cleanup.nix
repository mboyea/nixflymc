{ pkgs, name, version } : pkgs.writeShellApplication {
  name = "${name}-cleanup-${version}";
  runtimeInputs = [
  ];
  text = ''
    rm -rf banned-ips.json banned-players.json eula.txt libraries logs ops.json server.properties usercache.json versions whitelist.json world
  '';
}

