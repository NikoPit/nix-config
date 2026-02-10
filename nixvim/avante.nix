{
  plugins.avante = {
    enable = true;
    settings = {
      provider = "deepseek";
      providers = {
        deepseek = {
	  					endpoint = "https://api.deepseek.com";
					model = "deepseek-coder";
					max_tokens = 8192;
	};
      };
    };
  };
}
