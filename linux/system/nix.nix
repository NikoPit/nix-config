{ settings, ... }:
{
  nix = {
    settings = {
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
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
