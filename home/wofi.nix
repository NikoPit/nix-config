{
  programs.wofi = {
    enable = true;
  };

  #home.file.".config/wofi/style.css".source = ./rofi-style.css;
}
