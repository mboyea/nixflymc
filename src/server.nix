{ stdenv, name, version, system, nix-minecraft } : stdenv.mkDerivation {
  pname = "${name}-server";
  inherit version;
  src = nix-minecraft.packages.${system}.vanilla-server;
}

