{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../users/cody

    # ../common/global
    # ../common/users/cody
    #
    # ../common/optional/docker.nix
    # ../common/optional/nvidia-graphics.nix
    # ../common/optional/xbox-controller.nix
  ];

  networking.hostName = "lindon";
  nvidia-gpu.enable = true;

  home-manager.users.cody = import ../../users/cody/home.nix;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # # Configure the X11 windowing system.
  # services.xserver = {
  #   enable = true;
  #
  #   # Configure keymap in X11
  #   xkb = {
  #     layout = "us";
  #     variant = "";
  #   };
  # };
  #
  # # Enable the GNOME Desktop Environment.
  # services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true;
  #
  # system.stateVersion = "26.05";
}
