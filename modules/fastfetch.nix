{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo.type = "small";

      display = {
        separator = " ";

        color = {
          keys = "bright_blue";
          output = "bright_white";
        };

        key.type = "both";
      };

      modules = [
        "os"
        "kernel"

        "break"

        "cpu"
        "gpu"
        "memory"
        "disk"

        "break"

        "shell"
        "terminal"
        "wm"
      ];
    };
  };
}
