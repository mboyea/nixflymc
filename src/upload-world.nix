{ pkgs, name, version } : pkgs.writeShellApplication {
  name = "${name}-upload-world-${version}";
  runtimeInputs = [
    pkgs.flyctl
    pkgs.wireguard-tools
    pkgs.openssh
  ];
  text = ''
    echo "Enter the path to the world folder: "
    read -r -e new_world_folder

    flyctl ssh issue personal ${name}-ssh --hours 1 --overwrite
    flyctl wireguard create personal den "$(hostname)-${name}" wg.conf
    sudo mkdir -p /etc/wireguard && sudo cp wg.conf /etc/wireguard
    sudo wg-quick up wg

    scp -o UserKnownHostsFile=/dev/null -r -i ${name}-ssh "$new_world_folder" root@nixflymc.internal:/new-world
    echo "! THE SCRIPT FAILS HERE ! - manually complete its functions"
    # ! something here isn't working BUT it works when run manually so atm idc
    ssh -o UserKnownHostsFile=/dev/null -i ${name}-ssh root@nixflymc.internal << EOF
    rm -rf /world/*
    mv /new-world/* /world
    rm -rf /new-world
    EOF

    sudo wg-quick down wg
    sudo rm -rf /etc/wireguard/wg.conf
    flyctl wireguard remove personal "$(hostname)-${name}"
    rm wg.conf ${name}-ssh ${name}-ssh-cert.pub
  '';
}

