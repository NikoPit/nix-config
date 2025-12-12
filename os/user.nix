{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.elysia = {
    isNormalUser = true;
    description = "elysia";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
}
