{ pkgs , ... }:


pkgs.writeShellScriptBin "nix-update" ''
  git add ./*
  git commit -m "$1"
  sudo nixos-rebuild switch --flake ./ 
''

