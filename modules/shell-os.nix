{
  programs = {
    fish.enable = true;

    starship = {
      enable = true;

      interactiveOnly = true;

      transientPrompt = {
        enable = true;
        left = "starship module character";
      };

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
