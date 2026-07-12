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
    };
  };
}
