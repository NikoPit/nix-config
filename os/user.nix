{ pkgs, settings, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${settings.user.name} = {
    isNormalUser = true;
    description = settings.user.name;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
    shell = pkgs.fish;
  };
}
