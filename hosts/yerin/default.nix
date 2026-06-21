{
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-13th-gen
    outputs.nixosModules
    ./hardware-configuration.nix
    ../../users/cody
  ];

  networking.hostName = "yerin";
  goodix-fingerprint.enable = true;

  home-manager.users.cody = {
    imports = [../../users/cody/home.nix ./niri-settings.nix];
  };
}
