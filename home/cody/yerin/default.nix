{lib, ...}: {
  imports = [
    ../common/global

    ../common/optional/apps
    ../common/optional/gnome
  ];

  home.stateVersion = lib.mkDefault "25.05";
}
