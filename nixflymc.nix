{ stdenv, writeShellScriptBin }: let
  root = stdenv.mkDerivation {
    name = "nixflymc-static";
    version = "0.0.0";
    src = ./.;
    # buildInputs = [
    # ];
    # buildPhase = ''
    #   mkdir root
    # '';
    # installPhase = ''
    #   mkdir $out
    # '';
  };
in writeShellScriptBin "nixflymc" ''
  echo Hello, World!
  exit $?
''
