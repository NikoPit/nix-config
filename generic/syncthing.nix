let
  allDevices = [
    "phone"
    "huaweiPad"
  ];
in
{
  services.syncthing = {
    enable = true;

    settings = {
      devices = {
        phone.id = "K62Q5NH-64PL6IZ-FW436AE-GDROVBN-JRTVEP4-2SGFKZT-WEJAX64-DQE4RAM";
        huaweiPad.id = "I2724YZ-DSDPNJZ-TZVQP6I-LVA2BYR-3HRXPDY-FIP5UJL-LUW462O-W4ROZQ7";
      };

      folders = {
        notes = {
          path = "~/notes";
          devices = allDevices;
        };

        kimishinuClone = {
          path = "~/kimishinu-clone";
          devices = allDevices;
        };
      };
    };

  };
}
