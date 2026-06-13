{ pkgs, ... }:

pkgs.writeShellScriptBin "nix-update" ''
  cd ~/nix
  git add ./*
  sudo nixos-rebuild switch --flake ./

  if [ $? -eq 0 ]
  then
    git commit -m "$1"
    git push origin master
  fi
''
