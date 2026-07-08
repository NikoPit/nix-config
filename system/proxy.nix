{ pkgs, settings, ... }:

let
  proxySettings = settings.proxy;
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
        url = proxySettings.subscription.url;
        path = "./providers/airport.yaml";
        interval = proxySettings.subscription.updateInterval;
        proxy = "DIRECT";

        health-check = {
          enable = true;
          url = "https://cp.cloudflare.com";
          interval = proxySettings.subscription.healthCheckInterval;
        };
      };
    };

    proxy-groups = [
      {
        name = "PROXY";
        type = "url-test";
        use = [ "airport" ];
        url = "https://cp.cloudflare.com";
        interval = proxySettings.urlTest.interval;
        tolerance = proxySettings.urlTest.tolerance;
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
