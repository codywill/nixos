{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../users/cody
  ];

  networking.hostName = "lindon";

  docker.enable = true;
  nvidia-gpu.enable = true;
  hardware.xone.enable = true;

  home-manager.users.cody = {
    imports = [ ../../users/cody/home.nix ./niri-outputs.nix ];
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
