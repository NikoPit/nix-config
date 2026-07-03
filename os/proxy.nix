{ pkgs, ... }:

let
  airportSubscription = "https://0b96e976-9ec3-44c0-aa2b-30bf8b0792ea.com/sabusuku?token=a4328d9669100b0158e45c0d60fc9724";
  yaml = pkgs.formats.yaml { };
  nameserver = [
    "223.5.5.5"
    "119.29.29.29"
    "1.1.1.1"
    "8.8.8.8"

  ];
  mihomoConfig = yaml.generate "mihomo-config.yaml" {
    mode = "rule";

    dns = {
      enable = true;
      listen = "0.0.0.0:1053";
      enhanced-mode = "fake-ip";

      default-nameserver = nameserver;
      proxy-server-nameserver = nameserver;
      nameserver = nameserver;
    };

    tun = {
      enable = true;
      stack = "system";
      auto-route = true;
      auto-detect-interface = true;
      dns-hijack = [ "any:53" ];
    };

    proxy-providers = {
      airport = {
        type = "http";
        url = airportSubscription;
        path = "./providers/airport.yaml";
        interval = 300;
        proxy = "DIRECT";

        health-check = {
          enable = true;
          url = "https://cp.cloudflare.com";
          interval = 20;
        };
      };
    };

    proxy-groups = [
      {
        name = "PROXY";
        type = "url-test";
        use = [ "airport" ];
        url = "https://cp.cloudflare.com";
        interval = 5;
        tolerance = 50;
      }

      {
        name = "FINAL";
        type = "select";
        proxies = [
          "PROXY"
          "DIRECT"
        ];
      }
    ];

    rules = [
      "GEOIP,CN,DIRECT"
      "MATCH,FINAL"
    ];
  };
in
{
  services.mihomo = {
    enable = true;
    configFile = mihomoConfig;
    tunMode = true;
  };

  # Allows the Meta interface for mihomo TUN
  networking.firewall = {
    trustedInterfaces = [ "Meta" ];
    checkReversePath = false;
  };
}
