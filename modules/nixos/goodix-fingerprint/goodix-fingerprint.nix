{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.goodix-fingerprint;
in {
  config = lib.mkIf cfg.enable {
    systemd.services.fprintd = {
      wantedBy = ["multi-user.target"];
      serviceConfig.Type = "simple";
    };

    services.fprintd = {
      enable = true;
      tod.driver = pkgs.libfprint-2-tod1-goodix;
    };
  };
}
