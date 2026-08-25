{
  makeShortcut = { command, key }: {
    action = "<cmd>${command}<cr>";
    inherit key;
  };
}
