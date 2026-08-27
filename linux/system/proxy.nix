{
  pkgs,
  settings,
  config,
  ...
}:

let
  proxySettings = settings.proxy;
  yaml = pkgs.formats.yaml { };
  domesticNameserver = [
    "223.5.5.5"
    "119.29.29.29"
  ];

  # Use domestically reachable DoH as fallback: the previous 1.1.1.1/dns.google
  # DoH are unreachable from mainland China, so any non-CN IP resolved by the
  # primary nameserver (e.g. subscription domain behind Cloudflare) triggered
  # the fallback-filter and failed, breaking proxy-provider pulls.
  fallbackNameserver = [
    "https://doh.pub/dns-query"
    "https://dns.alidns.com/dns-query"
  ];

  airportToken = config.sops.placeholder.airport-token;
  subscriptionUrl = "https://sub1.smallstrawberry.com/api/v1/client/subscribe?token=${airportToken}";

  mihomoConfig = yaml.generate "mihomo-config.yaml" {
    mode = "rule";
    external-controller = "127.0.0.1:9090";

    dns = {
      enable = true;
      listen = "0.0.0.0:1053";
      enhanced-mode = "redir-host";

      default-nameserver = domesticNameserver;
      proxy-server-nameserver = domesticNameserver;
      nameserver = [
        "https://dns.alidns.com/dns-query"
        "https://doh.pub/dns-query"
      ];
      fallback = fallbackNameserver;
      fallback-filter = {
        geoip = true;
        geoip-code = "CN";
      };
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
        url = subscriptionUrl;
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
        name = "AUTO";
        type = "url-test";
        use = [ "airport" ];
        url = "https://cp.cloudflare.com";
        interval = proxySettings.urlTest.interval;
        tolerance = proxySettings.urlTest.tolerance;
      }

      {
        name = "MANUAL";
        type = "select";
        use = [ "airport" ];
        proxies = [
          "AUTO"
          "DIRECT"
        ];
      }

      {
        name = "FINAL";
        type = "select";
        proxies = [
          "MANUAL"
          "AUTO"
          "DIRECT"
        ];
      }
    ];

    rules = [
      "DOMAIN-SUFFIX,fishonmc.net,DIRECT"
      "DOMAIN-SUFFIX,e-flowcode.cc,DIRECT"
      "DOMAIN-SUFFIX,harrys.gg,DIRECT"
      "DOMAIN-SUFFIX,aliyun.com,DIRECT"

      "GEOIP,CN,DIRECT"
      "MATCH,FINAL"
    ];
  };
in
{
  sops = {
    secrets.airport-token = { };

    templates.mihomoConfig = {
      content = builtins.readFile mihomoConfig;
      owner = "root";
      group = "root";
      mode = "0400";
      restartUnits = [ "mihomo.service" ];
    };
  };

  services.mihomo = {
    enable = true;
    configFile = config.sops.templates.mihomoConfig.path;
    tunMode = true;
  };

  # Allows the Meta interface for mihomo TUN
  networking.firewall = {
    trustedInterfaces = [ "Meta" ];
    checkReversePath = false;
  };
}
