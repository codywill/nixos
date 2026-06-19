{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./dotfiles
    ./gnome-desktop
    ./niri
    ./noctalia
    ./nvidia-dev
  ];
  home.packages = with pkgs; [
    # Headless
    btop
    dwt1-shell-color-scripts
    fastfetch
    gcr
    jq
    lazygit
    lua51Packages.lua
    lua51Packages.luarocks
    nixd
    ripgrep
    tree
    usbutils
    wget
    which
    # Desktop
    obsidian
    slack
    sone
    vesktop
    vivaldi
  ];
  programs = {
    git.enable = true;
    home-manager.enable = true;
    starship.enable = true;
    wezterm.enable = true;
  };
  home.stateVersion = lib.mkDefault "26.05";
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
  };
  services.gnome-keyring.enable = true;
}
