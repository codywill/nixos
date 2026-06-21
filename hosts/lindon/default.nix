{
  outputs,
  pkgs,
  ...
}: {
  imports = [
    outputs.nixosModules
    ./hardware-configuration.nix
    ../../users/cody
  ];

  networking.hostName = "lindon";

  docker.enable = true;
  nvidia-gpu.enable = true;
  hardware.xone.enable = true;

  home-manager.users.cody = {
    imports = [../../users/cody/home.nix ./niri-settings.nix];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    package = pkgs.steam.override {
      extraArgs = "-system-composer";
    };
  };
}
