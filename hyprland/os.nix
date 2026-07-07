{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  _module.args.greeterSession = "uwsm start hyprland";
}
