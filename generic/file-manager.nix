{
  programs.yazi = {
    enable = true;

    shellWrapperName = "y";
  };

  _module.args.fileManager = "yazi";
}
