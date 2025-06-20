{lib, ...}: {
  imports = [
    ../common/global

    ../common/optional/apps
    ../common/optional/gnome
  ];

  # 4k screen configs
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.stateVersion = lib.mkDefault "25.05";
}
