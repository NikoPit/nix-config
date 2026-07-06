{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  _module.args.greetdSession = "uwsm start hyprland";
}
