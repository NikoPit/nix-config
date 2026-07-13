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

        key.type = "both";
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
