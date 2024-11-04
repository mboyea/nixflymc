{ pkgs, name, version } : pkgs.writeShellApplication {
  name = "${name}-upload-world-${version}";
  runtimeInputs = [
    pkgs.flyctl
    pkgs.wireguard-tools
    pkgs.openssh
  ];
  text = ''
    echo "Enter the file save name: "
    read -r -e save_world_name

    flyctl ssh issue personal ${name}-ssh --hours 1 --overwrite
    flyctl wireguard create personal den "$(hostname)-${name}" wg.conf
    sudo mkdir -p /etc/wireguard && sudo cp wg.conf /etc/wireguard
    sudo wg-quick up wg

    scp -o UserKnownHostsFile=/dev/null -r -i ${name}-ssh root@nixflymc.internal:/world "worlds/''${save_world_name}_$(date +%Y-%m-%d)"

    sudo wg-quick down wg
    sudo rm -rf /etc/wireguard/wg.conf
    flyctl wireguard remove personal "$(hostname)-${name}"
    rm wg.conf ${name}-ssh ${name}-ssh-cert.pub
  '';
}

