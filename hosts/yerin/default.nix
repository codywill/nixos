{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-13th-gen
    ./hardware-configuration.nix

    ../common/global
    ../common/users/cody

    ../common/optional/gnome-vrr.nix
    ../common/optional/goodix-fingerprint.nix
  ];

  networking = {
    hostName = "yerin";
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
