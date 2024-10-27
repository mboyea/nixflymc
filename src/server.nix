{ writeShellApplication, name, version } : writeShellApplication {
  name = "${name}-server-${version}";
  runtimeInputs = [];
  text = ''
    echo "Hello, you big bad world!"
    echo "I'm going to sleep."
    tail -f /dev/null
    exit 0
  '';
}

