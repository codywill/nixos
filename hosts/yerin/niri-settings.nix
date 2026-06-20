{...}: {
  programs.niri.settings = {
    outputs = {
      "Samsung Display Corp. ATNA40HQ02-0  Unknown" = {
        focus-at-startup = true;
        mode = {
          width = 2880;
          height = 1800;
          refresh = 120.0;
        };
        variable-refresh-rate = "on-demand";
      };
    };
  };
}
