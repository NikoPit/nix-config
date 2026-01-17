{
  nix.settings = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store" 
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://nix-citizen.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://linux-surface.cachix.org"
    ];
    trusted-public-keys = [
      "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };
}
