{
  pkgs,
  outputs,
  ...
}: {
  imports = [
    outputs.homeManagerModules
  ];

  fish.enable = true;
  niri.enable = true;
  noctalia.enable = true;
  starship.enable = true;
  vesktop.enable = true;
  wezterm.enable = true;

  home = {
    username = "cody";
    homeDirectory = "/home/cody";
    packages = with pkgs; [
      obsidian
      slack
      sone
      vesktop
      vivaldi
    ];
  };

  dotfiles = {
    path = "/home/cody/sources/codywill/dotfiles";
    configs = {
      tmux = "tmux";
      nvim = "nvim/.config/nvim";
    };
  };

  programs.git.settings.user = {
    name = "cody";
    email = "24554738+codywill@users.noreply.github.com";
  };

  services.gnome-keyring.enable = true;
}
