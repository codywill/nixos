{pkgs, ...}: {
  systemd.services.fprintd = {
    wantedBy = ["multi-user.target"];
    serviceConfig.Type = "simple";
  };

  services.fprintd = {
    enable = true;
    tod.driver = pkgs.libfprint-2-tod1-goodix;
  };
}
