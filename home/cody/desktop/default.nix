{lib, ...}: {
  imports = [
    ../common/global

    # TODO: maybe package these up into a directory
    ../common/optional/discord.nix
    ../common/optional/gnome-extensions.nix
    ../common/optional/obsidian.nix
    ../common/optional/slack.nix
    ../common/optional/tidal.nix
    ../common/optional/vivaldi.nix
  ];

  # 4k screen configs
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.stateVersion = lib.mkDefault "25.05";
}
