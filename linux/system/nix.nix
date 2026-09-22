{ settings, ... }:
{
  nix = {
    settings = {
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Allow wheel members to have Nix honor per-user settings, such as the
      # substituters a flake declares in its own nixConfig.
      trusted-users = [
        "root"
        "@wheel"
      ];

      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      ];
    };

    gc = {
      automatic = true;
      dates = settings.misc.nixGC.dates;
    };
  };

  nixpkgs.config.allowUnfree = true;
}
