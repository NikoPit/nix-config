{
  applicationLauncher,
  terminal,
  screenshot,
  ...
}:

[
  "SUPER, Q, exec, ${terminal}"
  "SUPER, C, killactive"
  "SUPER, V, togglefloating"
  ", Print, exec, ${screenshot}"

  "SUPER, SPACE, exec, ${applicationLauncher}"

  "SUPER, 1, workspace, 1"
  "SUPER, 2, workspace, 2"
  "SUPER, 3, workspace, 3"
  "SUPER, 4, workspace, 4"
  "SUPER, 5, workspace, 5"
  "SUPER, 6, workspace, 6"
  "SUPER, 7, workspace, 7"
  "SUPER, 8, workspace, 8"
  "SUPER, 9, workspace, 9"
]
