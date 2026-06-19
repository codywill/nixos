{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.noctalia-greeter;
in {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  options.noctalia-greeter = {
    enable = lib.mkEnableOption "Enable noctalia greeter";
  };

  config = lib.mkIf cfg.enable {
    programs.noctalia-greeter = {
      enable = true;
      package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;

      # Optional configuration
      greeter-args = "";
      settings.cursor = {
        theme = "Adwaita";
        size = 24;
        package = pkgs.adwaita-icon-theme;
      };
    };
  };
}
