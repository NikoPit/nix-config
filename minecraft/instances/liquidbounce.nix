{ pkgs, ... }:

let
  jcefSrc = pkgs.fetchFromGitHub {
    owner = "CCBlueX";
    repo = "java-cef";
    rev = "aa20e50dbfb858ea50d3cf405b8202462dd10d96";
    hash = "sha256-gLDiARy35KixTnS/G8U5NQvm2hjz4yl+O6dgnWNrGMY=";
  };

  jcef = pkgs.callPackage jcefSrc { };
in
{
  enable = true;

  version = "26.1.2";
  assetHash = "sha256-Jblp3zLP6HOphGT2cWTFvuu+EBkdfdWei9CrGP0xaUc=";

  desktopEntry.name = "Liquid Bounce";

  fabricLoader.enable = true;
  mods = {
    liquidbounce = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/NikoPit/misc-resources/main/liquidbounce-0.38.jar";
      hash = "sha256-x9aDU2DEDt/Wv99u4+1GxlzvwtiV15PLACF5eL1NxBI=";
    };

    fabric-lang-kotlin = pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/Ha28R6CL/versions/Pd0xrHCw/fabric-language-kotlin-1.13.12%2Bkotlin.2.4.0.jar?mr_download_reason=standalone&mr_game_version=26.1.2&mr_loader=fabric";
      hash = "sha256-NsXdi3KONHDSiCrmMRm5OiBQD8Dqb1yUXBK/ZbWrGDI=";
    };
  };

  runtimeLibs = with pkgs; [
    libgbm
    glib
    nss
    nspr
    atk
    at-spi2-atk
    libdrm
    expat
    libxcb
    libxkbcommon
    libXcomposite
    libXdamage
    libXext
    libXfixes
    libXrandr
    gtk3
    pango
    cairo
    alsa-lib
    dbus
    at-spi2-core
    cups
    libxshmfence
    wayland
  ];

  envVars = {
    PROVIDED_JCEF_PATH = "${jcef}";
    WEBKIT_DISABLE_DMABUF_RENDERER = "1";
  };
}
