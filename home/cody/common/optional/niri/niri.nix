{
  lib,
  config,
  ...
}: let
  cfg = config.niri;
in {
  options.niri = {
    enable = lib.mkEnableOption "Enable niri";
  };

  config = lib.mkIf cfg.enable {
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
