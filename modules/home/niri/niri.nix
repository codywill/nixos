{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.niri;
in {
  imports = [
    inputs.niri-flake.homeModules.niri
    ./niri-default-settings.nix
  ];

  options.niri = {
    enable = lib.mkEnableOption "Enable niri";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [fuzzel swaylock xwayland-satellite];

    programs.niri.settings = {
      outputs."LG Electronics LG TV SSCR2 0x01010101" = {
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
      outputs."Dell Inc. Dell S2716DG #ASNVXbMXJiXd" = {
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
      spawn-at-startup = [
        {command = ["noctalia"];}
        {command = ["xwayland-satellite"];}
      ];
    };
  };
}
