{ writeShellApplication, name ? "server", version } : writeShellApplication {
  name = "${name}-${version}";
  runtimeInputs = [];
  text = ''
    echo "Hello, you big bad world!"
    exit 0
  '';
}

# { stdenv, name ? "server", version }: stdenv.mkDerivation {
#   pname = "${name}";
#   inherit version;
#   src = ./.;
#   buildInputs = [
#     # Infinidoge/nix-minecraft
#   ];
#   buildPhase = ''
#     echo "building server dependencies"
#   '';
#   installPhase = ''
#     echo "installing server"
#     # mkdir -p $out/bin
#     # cp -r foo $out/bin
#   '';
#   shellHook = ''
#     echo "running server"
#     # echo "Hello, you big bad world!" && exit $?
#   '';
# }

# # The following will work, but it's ugly and I can't find a reference for this syntax anywhere!
# # I must understand what's going on before I reproduce this syntax.
# # src: https://github.com/LutrisEng/nix-fly-template/blob/main/app.nix
# 
# { stdenv, writeShellScriptBin }: let
#   root = stdenv.mkDerivation {
#     name = "app-static";
#     src = ./.;
#     buildInputs = [
#       pandoc
#     ];
#     buildPhase = ''
#       mkdir root
#       pandoc README.md README.yaml -s -o root/index.html
#     '';
#     installPhase = ''
#       mkdir $out
#       cp -R root/* $out/
#     '';
#   };
#   conf = writeText "nginx.conf" ''
#     user nobody nobody;
#     daemon off;
#     error_log /dev/stdout info;
#     pid /dev/null;
#     events {}
#     http {
#       access_log /dev/stdout;
#       server {
#         listen 8080;
#         index index.html;
#         add_header X-Root-Path ${root};
#         location / {
#           root ${root};
#         }
#       }
#     }
#   '';
# in writeShellScriptBin app ''
#   echo Starting nginx
#   ${nginx}/bin/nginx -c ${conf}
#   echo nginx exited with code $?
#   exit $?
# ''

