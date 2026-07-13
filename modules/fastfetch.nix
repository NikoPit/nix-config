{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo.type = "small";

      display = {
        separator = " ";
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
