let
  httpProxy = "http://127.0.0.1:7890";
  allProxy = "socks5://127.0.0.1:7890";
  noProxy = "127.0.0.1,localhost,::1";
in
{
  networking.proxy.httpProxy = httpProxy;
  networking.proxy.httpsProxy = httpProxy;
  networking.proxy.allProxy = allProxy;
  networking.proxy.noProxy = noProxy;

  environment.sessionVariables = {
    HTTP_PROXY = httpProxy;
    HTTPS_PROXY = httpProxy;
    ALL_PROXY = allProxy;
    NO_PROXY = noProxy;

    http_proxy = httpProxy;
    https_proxy = httpProxy;
    all_proxy = allProxy;
    no_proxy = noProxy;
  };
}
