{ lib, pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      waylandFrontend = true;

      addons = with pkgs; [
        fcitx5-gtk

        fcitx5-pinyin-minecraft
        fcitx5-pinyin-moegirl
        fcitx5-pinyin-zhwiki

        qt6Packages.fcitx5-chinese-addons
      ];

      # Temporary workaround for https://github.com/nix-community/stylix/issues/2502
      themes.stylix.theme = {
        "InputPanel/Background/Margin" = {
          Left = lib.mkForce 14;
          Right = lib.mkForce 14;
          Top = lib.mkForce 14;
          Bottom = lib.mkForce 14;
        };
        "InputPanel/Highlight/Margin" = {
          Left = lib.mkForce 14;
          Right = lib.mkForce 14;
        };
      };

      settings = {
        inputMethod = {
          GroupOrder."0" = "Default";

          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "pinyin";
          };

          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "pinyin";
        };

        addons.cloudpinyin.globalSection.Backend = "Baidu";
      };
    };
  };
}
