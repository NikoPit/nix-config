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
        starship_transient_prompt_func = ''
          printf " "
          starship module character
        '';
      };
    };

    ghostty.enableFishIntegration = true;

    starship = {
      enable = true;
      enableInteractive = true;
      enableFishIntegration = true;
      enableTransience = true;

      settings = {
        format = ''
          [  $directory](bold blue)
          [ $character](bold darkblue)
        '';
        right_format = "$status";

        status = {
          format = "[$symbol $status]($style)";

          symbol = "";
          not_found_symbol = "";
          not_executable_symbol = "󰂭";
          signal_symbol = "󰉁";
          sigint_symbol = "󰟾";

          map_symbol = true;
          pipestatus = true;

          disabled = false;
        };

        character.format = "[❯ ](bold blue)";
        add_newline = true;
      };
    };
  };
}
