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
    home.packages = with pkgs; [fuzzel swaylock];

    programs.niri = {
      enable = true;
      settings = {
        outputs."eDP-1".scale = 2.0;
        spawn-at-startup = [
          {
            command = ["noctalia"];
          }
        ];
      };
    };
  };
}
