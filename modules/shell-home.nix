{
  programs.fish = {
    enable = true;

    functions.fish_user_key_bindings = "fish_vi_key_bindings";
  };

  programs.ghostty.enableFishIntegration = true;
}
