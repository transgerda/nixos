{ pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    hostName = "bamilaptop"; 

    firewall = {
      trustedInterfaces = [ "virbr0" ];
      allowedTCPPorts = [ 11434 57621 5353 ];
      allowedUDPPorts = [ 9 ];
    };

    interfaces = {
      wlo1 = {
        wakeOnLan.enable = true;
      };
    };

    # gta anticheat
    extraHosts = ''
      0.0.0.0 paradise-s1.battleye.com
      0.0.0.0 test-s1.battleye.com
      0.0.0.0 paradiseenhanced-s1.battleye.com
    '';
  };
}

