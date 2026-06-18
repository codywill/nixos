{
  config,
  lib,
  ...
}: let
  cfg = config.docker;
in {
  options.docker = {
    enable = lib.mkEnableOption "Use docker";
  };
  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
    };
  };
}
