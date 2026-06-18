{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.gnome;
in {
  options.gnome = {
    enable = lib.mkEnableOption "Use gnome desktop";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [
      blur-my-shell
      hide-top-bar
      wallpaper-slideshow
    ];
  };
}
