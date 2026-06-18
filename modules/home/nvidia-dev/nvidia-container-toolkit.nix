{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nvidia-devtools;
in {
  options.nvidia-devtools = {
    enable = lib.mkEnableOption "Use nvidia dev tools";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nvidia-container-toolkit
    ];
  };
}
