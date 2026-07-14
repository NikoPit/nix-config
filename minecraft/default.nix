{
  nixcraft = {
    enable = true;

    client = {
      shared = { };

      instances = {
        latest = {
          enable = true;
          version = "1.21.1";
          desktopEntry.enable = true;
        };
      };
    };
  };
}
