{ stdenv, name, version, system, nix-minecraft } : stdenv.mkDerivation rec {
  pname = "${name}-server";
  inherit version;
  src = nix-minecraft.packages.${system}.vanilla-server;
  installPhase = ''
    mkdir -p $out/bin $out/lib
    cp -r -v $src $out/lib/minecraft-server

    cat > $out/bin/${pname} << EOF
    #!/bin/bash
    echo 'eula=TRUE' > eula.txt
    $out/lib/minecraft-server/bin/minecraft-server
    EOF

    chmod +x $out/bin/${pname}
  '';
  meta.mainProgram = "${pname}";
}




# { pkgs, name, version, system, nix-minecraft } : let
#   minecraftServer = nix-minecraft.packages.${system}.vanilla-server;
# in pkgs.writeShellApplication {
#   name = "${name}-deploy-${version}";
#   runtimeInputs = [
#     minecraftServer
#   ];
#   text = ''
#     # exec /nix/store/8jw82agvyakkjmrndxgj98fb9dn64m0j-openjdk-headless-21+35/bin/java $@ -jar /nix/store/bl611hbmd0cmddwla6a75drzz4jdrzck-minecraft-server-1.21.3/lib/minecraft/server.jar nogui
#     ${minecraftServer}/bin/minecraft-server
#   '';
# }





# let
#   minecraftServer = 
#   
#   root = stdenv.mkDerivation {
#     pname = "${name}-server";
#     inherit version;
#     src = ./.;
#     eula = writeText "eula.txt" ''
#       # By setting the below value to TRUE, you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA).
#       eula=TRUE
#     '';
#     installPhase = ''
#       mkdir -p $out/test
#       cp $eula $out
#     '';
#     shellHook = minecraftServer;
#   };
# in minecraftServer


#  writeShellScriptBin "${name}" ''
#  ''


# { pkgs, name, version ? "latest", image, flyConfig ? "fly.toml" } : pkgs.writeShellApplication {
#   name = "${name}-deploy-${version}";
#   runtimeInputs = [
#     image
#     flyConfig
#     pkgs.skopeo
#     pkgs.flyctl
#   ];
#   text = ''
#     #!/usr/bin/env bash
# 
#     echoerror() { echo "Error:" "$@" 1>&2; }
# 
#     load_env() {
#       if [ -r .env ]; then
#         set -a
#         # shellcheck disable=SC1091
#         source .env
#         set +a
#       fi
#     }
# 
#     test_env() {
#       while [[ $# -gt 0 ]]; do
#         if [ -z "$1" ]; then
#           echoerror The required environment variable "$1" is not defined
#           exit 1
#         fi
#         shift
#       done
#     }
# 
#     update_docker_image() {
#       skopeo --insecure-policy copy --dest-creds="$DOCKER_USERNAME:$DOCKER_PASSWORD" "tarball:${image}" "docker://docker.io/$DOCKER_USERNAME/${name}:${version}"
#     }
# 
#     deploy_to_fly() {
#       flyctl deploy -c ${flyConfig} -i "docker.io/$DOCKER_USERNAME/${name}:${version}"
#     }
# 
#     load_env
#     test_env DOCKER_USERNAME DOCKER_PASSWORD FLY_API_TOKEN
#     update_docker_image
#     deploy_to_fly
#   '';
# }


