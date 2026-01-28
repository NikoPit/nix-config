{ pkgs, ... }:

{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        rust = [ "rustfmt" ];
      };

      format_on_save = {
        timeout_ms = 500;
      };
    };
  };

  environment.systemPackages = [pkgs.rustfmt];
}
