{ pkgs, ... }:

{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        sh = [ "shfmt" ];
        bash = [ "shfmt" ];
        rust = [ "rustfmt" ];
        nix = [ "nixfmt" ];
      };

      format_on_save = {
        timeout_ms = 500;
      };
    };
  };
}
