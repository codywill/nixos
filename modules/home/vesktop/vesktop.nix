{
  config,
  lib,
  ...
}: let
  cfg = config.vesktop;
in {
  options.vesktop = {
    enable = lib.mkEnableOption "Use vesktop home config";
  };
  config = lib.mkIf cfg.enable {
    programs.vesktop = {
      enable = true;
      vencord = {
        themes = {
          "system24-custom" = builtins.readFile ./system24-custom.theme.css;
        };
        settings = {
          # useSystem = true;
          enabledThemes = ["system24-custom.css"];
        };
      };
    };
  };
}
