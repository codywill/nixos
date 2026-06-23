{
  config,
  lib,
  ...
}: let
  cfg = config.wezterm;
in {
  options.wezterm = {
    enable = lib.mkEnableOption "Use wezterm home config";
    extraSettings = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      default = {};
    };
  };
  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;

      settings =
        {
          color_scheme = "Atelier Plateau (base16)";

          default_prog = ["tmux"];

          font = lib.generators.mkLuaInline ''            wezterm.font({
                        family = 'VictorMono Nerd Font',
                        style = 'Normal',
                        weight = 'DemiBold'
                    })'';

          hide_tab_bar_if_only_one_tab = true;

          initial_cols = 120;
          initial_rows = 40;

          window_padding = {
            left = 0;
            right = 0;
            top = 0;
            bottom = 0;
          };
        }
        // cfg.extraSettings;
    };
  };
}
