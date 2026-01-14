{
    nix.settings = {
        substituters = [
	    "https://nix-citizen.cachix.org"
            "https://mirrors.ustc.edu.cn/nix-channels/store" 
	];
        trusted-public-keys = ["nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="];
    };
}
