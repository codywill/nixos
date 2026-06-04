{lib, ...}: {
  imports = [
    ../common/global

    ../common/optional/apps
    ../common/optional/gnome

    ../common/optional/dev/nvidia-container-toolkit.nix
  ];

  # 4k screen configs
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.stateVersion = lib.mkDefault "26.05";
}
