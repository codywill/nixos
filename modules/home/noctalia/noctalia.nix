{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.noctalia;
in {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  options.noctalia = {
    enable = lib.mkEnableOption "Enable noctalia";
  };

  config = lib.mkIf cfg.enable {
    programs.noctalia = {
      enable = true;

      settings = {
        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Catppuccin";
        };

        wallpaper = {
          enabled = true;
          directory = "/home/cody/Pictures/Wallpapers";
          automation = {
            enabled = true;
            interval_seconds = 1800;
            order = "random";
            recursive = true;
          };
        };

        shell = {
          ui-scale = 2.0;
        };

        bar.main = {
          auto_hide = true;
          reserve_space = false;
          end = [
            "tray"
            "notifications"
            "clipboard"
            "network"
            "bluetooth"
            "volume"
            "brightness"
            "battery"
            "control-center"
            "session"
          ];
        };

        location.address = "Los Angeles, CA";
        weather.enabled = true;
      };
    };
  };
}
