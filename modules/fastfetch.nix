{
  programs.fastfetch = {
    enable = true;

    settings = {
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
