{
  services.distccd = {
    enable = true;
    allowedClients = [ "192.168.31.186" ];
  };
  networking.firewall.allowedTCPPorts = [ 3632 ];
}
