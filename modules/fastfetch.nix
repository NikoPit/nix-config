{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo.type = "small";

      display = {
        separator = " ";

        color = {
          keys = "bright_blue";
        };
      };

      modules = [
        "os"
        "kernel"
        "cpu"
        "gpu"
        "memory"
        "shell"
        "terminal"
        "wm"
        "disk"
      ];
    };
  };
}
