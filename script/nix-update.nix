{ pkgs , ... }:


pkgs.writeShellScriptBin "nix-update" ''
  git add ./*
  sudo nixos-rebuild switch --flake ./ 

  if [ $? -eq 0 ]
  then
    nix_generation=$(cat ./.nix-generation)
    new_nix_generation=$(($nix_generation+1))
    echo $new_nix_generation >./.nix-generation

    git commit -m "[Generation "$new_nix_generation"] $1"
    git push origin master
  fi
''

