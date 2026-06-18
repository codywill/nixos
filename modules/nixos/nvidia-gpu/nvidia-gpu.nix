{
  config,
  lib,
  ...
}: let
  cfg = config.nvidia-gpu;
in {
  options.nvidia-gpu = {
    enable = lib.mkEnableOption "Use nvidia gpu";
  };
  config = lib.mkIf cfg.enable {
    hardware = {
      graphics.enable = true;
      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
      };

      nvidia-container-toolkit.enable = true;
    };

    services.xserver.videoDrivers = ["nvidia"];
  };
}
