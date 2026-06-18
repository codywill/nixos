{inputs, ...}: {
  imports = [
    inputs.niri-flake.homeModules.niri
    ./niri-home-default.nix
    ./niri.nix
  ];
}
