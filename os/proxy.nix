{
  networking.proxy.httpProxy = "http://127.0.0.1:7890";
  networking.proxy.httpsProxy = "http://127.0.0.1:7890";
  networking.proxy.allProxy = "socks5://127.0.0.1:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost,::1";

  environment.variables = {
    HTTP_PROXY = "http://127.0.0.1:7890";
    HTTPS_PROXY = "http://127.0.0.1:7890";
    ALL_PROXY = "socks5://127.0.0.1:7890";
    NO_PROXY = "127.0.0.1,localhost,::1";
  };
}
