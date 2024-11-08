{ stdenv, name, version, system, nix-minecraft } : let
  serverProperties = ''
    accepts-transfers=false
    allow-flight=false
    allow-nether=true
    broadcast-console-to-ops=true
    broadcast-rcon-to-ops=true
    bug-report-link=
    difficulty=hard
    enable-command-block=false
    enable-jmx-monitoring=false
    enable-query=false
    enable-rcon=false
    enable-status=true
    enforce-secure-profile=true
    enforce-whitelist=true
    entity-broadcast-range-percentage=100
    force-gamemode=false
    function-permission-level=2
    gamemode=survival
    generate-structures=true
    generator-settings={}
    hardcore=false
    hide-online-players=false
    initial-disabled-packs=
    initial-enabled-packs=vanilla
    level-name=world
    level-seed=
    level-type=minecraft\:normal
    log-ips=true
    max-chained-neighbor-updates=1000000
    max-players=20
    max-tick-time=60000
    max-world-size=29999984
    motd=A Minecraft Server
    network-compression-threshold=256
    online-mode=true
    op-permission-level=4
    pause-when-empty-seconds=60
    player-idle-timeout=0
    prevent-proxy-connections=false
    pvp=true
    query.port=25565
    rate-limit=0
    rcon.password=
    rcon.port=25575
    region-file-compression=deflate
    require-resource-pack=false
    resource-pack=
    resource-pack-id=
    resource-pack-prompt=
    resource-pack-sha1=
    server-ip=
    server-port=25565
    simulation-distance=10
    spawn-monsters=true
    spawn-protection=16
    sync-chunk-writes=true
    text-filtering-config=
    text-filtering-version=0
    use-native-transport=true
    view-distance=10
    white-list=true
  '';
  whiteList = ''
    [
      {
        "uuid": "1be6e50c-3570-4bca-978e-05ec0f61790b",
        "name": "Firstson04",
      },
      {
        "uuid": "86f8096f-8998-4d36-8ef3-84ff3504f8ca",
        "name": "xTineke99x"
      },
      {
        "uuid": "423c9519-abfc-4df0-a078-fb21a2de8298",
        "name": "YourZombieMop"
      }
    ]
  '';
  ops = ''
    [
      {
        "uuid": "423c9519-abfc-4df0-a078-fb21a2de8298",
        "name": "YourZombieMop",
        "level": 4,
        "bypassesPlayerLimit": true
      }
    ]
  '';
  eula = ''
    # text before eula
    eula=TRUE
    # text after eula
  '';
in stdenv.mkDerivation rec {
  pname = "${name}-server";
  inherit version;
  src = nix-minecraft.packages.${system}.vanilla-server;
  installPhase = ''
    mkdir -p $out/bin $out/lib
    cp -r -v $src $out/lib/minecraft-server

    cat > $out/bin/${pname} << EOF
    #!/bin/bash
    echo '${eula}' > eula.txt
    echo '${serverProperties}' > server.properties
    echo '${whiteList}' > whitelist.json
    echo '${ops}' > ops.json

    $out/lib/minecraft-server/bin/minecraft-server
    EOF

    chmod +x $out/bin/${pname}
  '';
  meta.mainProgram = "${pname}";
}

