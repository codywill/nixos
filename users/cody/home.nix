{
  pkgs,
  outputs,
  ...
}: {
  imports = [
    outputs.homeManagerModules
  ];
  niri.enable = true;
  noctalia.enable = true;

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
      fish = "fish/.config/fish";
      tmux = "tmux";
      nvim = "nvim/.config/nvim";
      wezterm = "wezterm";
      "starship.toml" = "starship/.config/starship.toml";
    };
  };

  programs.git.settings.user = {
    name = "cody";
    email = "24554738+codywill@users.noreply.github.com";
  };

  services.gnome-keyring.enable = true;
}
