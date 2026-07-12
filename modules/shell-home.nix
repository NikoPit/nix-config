{
  programs = {
    fish = {
      enable = true;

      functions.fish_user_key_bindings = "fish_vi_key_bindings";
    };

    ghostty.enableFishIntegration = true;

    starship = {
      enable = true;
    };
  };
}
