{ writeShellApplication, name ? "server", version } : writeShellApplication {
  name = "${name}-${version}";
  runtimeInputs = [];
  text = ''
    echo "Hello, you big bad world!"
    echo "I'm going to sleep."
    tail -f /dev/null
    exit 0
  '';
}

