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
    home.packages = with pkgs; [
      fuzzel
      swaylock
      xwayland-satellite
    ];

    programs.niri.settings = {
      spawn-at-startup = [
        {command = ["noctalia"];}
        {command = ["xwayland-satellite"];}
      ];
    };
    programs.fuzzel = {
      enable = true;
      settings.colors = {
        background = "1e1e2edd";
        text = "cdd6f4ff";
        prompt = "bac2deff";
        placeholder = "7f849cff";
        input = "cdd6f4ff";
        match = "00baeeff";
        selection = "585b70ff";
        selection-text = "cdd6f4ff";
        selection-match = "00baeeff";
        counter = "7f849cff";
        border = "00baeeff";
      };
    };
  };
}
