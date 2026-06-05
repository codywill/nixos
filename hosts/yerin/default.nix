{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-13th-gen
    ./hardware-configuration.nix

    ../common/global
    ../common/users/cody

    ../common/optional/goodix-fingerprint.nix
  ];

  networking = {
    hostName = "yerin";
  };

  # Configure the X11 windowing system.
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  system.stateVersion = "26.05";
}
