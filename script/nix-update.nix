{ pkgs , ... }:


pkgs.writeShellScriptBin "nix-update" ''
  nix_generation=$(cat ./.nix-generation)
  new_nix_generation=$(($nix_generation+1))
  echo $new_nix_generation >./.nix-generation

  git add ./*
  git commit -m "[Generation "$new_nix_generation"] $1"
  sudo nixos-rebuild switch --flake ./ 
''

