{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.devtools;
in {
  options.devtools = {
    enable = lib.mkEnableOption "Enable devtools";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim
      wget
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.victor-mono
    ];

    programs = {
      fish.enable = true;
      neovim = {
        enable = true;
        defaultEditor = true;
      };
      tmux = {
        enable = true;
        clock24 = true;
      };
    };
  };
}
