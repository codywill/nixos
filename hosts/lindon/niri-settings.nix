{...}: {
  programs.niri.settings = {
    outputs = {
      "LG Electronics LG TV SSCR2 0x01010101" = {
        focus-at-startup = true;
        position = {
          x = 0;
          y = 0;
        };
        mode = {
          width = 3840;
          height = 2160;
          refresh = 119.880;
        };
      };
      "Dell Inc. Dell S2716DG #ASNVXbMXJiXd" = {
        position = {
          x = 3840;
          y = 0;
        };
        mode = {
          width = 2560;
          height = 1440;
          refresh = 143.964;
        };
        scale = 1.0;
        transform.rotation = 90;
      };
    };
  };
}
