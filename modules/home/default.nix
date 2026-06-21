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

  home = {
    stateVersion = lib.mkDefault "26.05";
    packages = with pkgs; [
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
      which
    ];
  };

  programs = {
    git.enable = true;
    home-manager.enable = true;
    starship.enable = true;
    wezterm.enable = true;
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
  };
}
