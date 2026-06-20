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
    home.file.".config/noctalia/palettes/CatppuccinCustom.json".source = ./CatppuccinCustom.json;

    programs.noctalia = {
      enable = true;

      settings = {
        theme = {
          mode = "dark";
          source = "custom";
          custom_palette = "CatppuccinCustom";
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
        weather = {
          enabled = true;
          unit = "imperial";
        };

        plugins.enabled = [
          "noctalia/screen-recorder"
        ];
      };
    };
  };
}
