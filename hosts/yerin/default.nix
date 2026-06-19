{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-13th-gen
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../users/cody
  ];

  networking.hostName = "yerin";
  goodix-fingerprint.enable = true;

  home-manager.users.cody = {
    imports = [../../users/cody/home.nix ./niri-outputs.nix];
  };
}
