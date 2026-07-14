{ pkgs, lib, ... }:

let
  options = {
    fov = "90";
    maxFps = "240";
    lang = "en_us";
    toggleSprint = "true";
    gamma = "1.0";
    guiScale = "2";
  };
in
pkgs.writeText "options.txt" (
  lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: "${k}:${v}") options)
)
