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

