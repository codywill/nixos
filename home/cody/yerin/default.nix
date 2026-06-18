{lib, ...}: {
  imports = [
    ../common/global

    ../common/optional/apps
    ../common/optional/niri
    ../common/optional/noctalia
  ];

  niri.enable = true;
  noctalia.enable = true;

  home.stateVersion = lib.mkDefault "26.05";
}
