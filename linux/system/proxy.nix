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

  yyjcToken = config.sops.placeholder.yyjc-token;
  yyjcSubUrl = "https://sub1.smallstrawberry.com/api/v1/client/subscribe?token=${yyjcToken}";

  sakuracatToken = config.sops.placeholder.sakuracat-token;
  sakuracatSubUrl = "https://cat.cn-ping.com/sabusuku?token=${sakuracatToken}";

  mkProvider = name: url: {
    type = "http";
    inherit url;
    path = "./providers/${name}.yaml";
    interval = proxySettings.subscription.updateInterval;
    proxy = "DIRECT";

    health-check = {
      enable = true;
      url = "https://cp.cloudflare.com";
      interval = proxySettings.subscription.healthCheckInterval;
    };
  };

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
      yyjc = mkProvider "yyjc" yyjcSubUrl;
      sakuracat = mkProvider "sakuracat" sakuracatSubUrl;
    };

    proxy-groups = [
      {
        name = "AUTO";
        type = "url-test";
        use = [
          "yyjc"
          "sakuracat"
        ];
        url = "https://cp.cloudflare.com";
        interval = proxySettings.urlTest.interval;
        tolerance = proxySettings.urlTest.tolerance;
      }

      {
        name = "MANUAL";
        type = "select";
        use = [
          "yyjc"
          "sakuracat"
        ];
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
    secrets = {
      yyjc-token = { };
      sakuracat-token = { };
    };

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
