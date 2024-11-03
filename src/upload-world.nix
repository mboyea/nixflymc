{ pkgs, name, version } : pkgs.writeShellApplication {
  name = "${name}-upload-world-${version}";
  runtimeInputs = [
    pkgs.flyctl
    pkgs.wireguard-tools
    pkgs.openssh
  ];
  text = ''
    echo "This script isn't complete, please read the src code and execute it manually yourself."

    flyctl ssh issue personal ${name}-ssh --hours 1 --overwrite
    flyctl wireguard create personal den $(hostname)-${name} wg.conf
    sudo wg-quick up ./wg.conf

    # ssh -i nixflymc-ssh root@nixflymc.internal "rm -rf /world/*"
    # scp -r -i nixflymc-ssh worlds/SJSMTCB/. root@nixflymc.internal:/world

    # ? sudo wg-quick down ./wg.conf
    flyctl wireguard remove personal $(hostname)-${name}
    rm wg.conf ${name}-ssh ${name}-ssh-cert.pub
  '';
}

