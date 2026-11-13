{ config, lib, ... }:

{
  programs = {
    fish = {
      enable = true;

      interactiveShellInit = lib.mkIf (config.shellHooks != [ ]) (
        lib.mkAfter (lib.concatStringsSep "\n" config.shellHooks)
      );

      functions = {
        fish_greeting = "";
        fish_user_key_bindings = "fish_vi_key_bindings";
      };
    };

    ghostty.enableFishIntegration = true;
  };
}
