{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/users/cody

    ../common/optional/nvidia-graphics.nix
    ../common/optional/xbox-controller.nix
  ];

  networking = {
    hostName = "desktop";
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Configure the X11 windowing system.
  services.xserver = {
    enable = true;

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  system.stateVersion = "25.05";
}
