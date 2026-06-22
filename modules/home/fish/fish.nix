{
  config,
  lib,
  ...
}: let
  cfg = config.fish;
in {
  options.fish = {
    enable = lib.mkEnableOption "Use fish home config";
  };
  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting
      '';

      functions = {
        fish_user_key_bindings = ''
          bind \cy forward-char
        '';
      };
    };
  };
}
