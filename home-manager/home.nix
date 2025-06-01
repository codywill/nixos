{
  # inputs,
  # outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # imports = [];

  options = {
    dotfiles = lib.mkOption {
      type = lib.types.path;
      apply = toString;
      default = "${config.home.homeDirectory}/sources/codywill/dotfiles";
      example = "${config.home.homeDirectory}/sources/codywill/dotfiles";
      description = "Location of the dotfiles working directory";
    };
  };

  config = {
    # nixpkgs = {
    #   overlays = [
    #     outputs.overlays.additions
    #     outputs.overlays.modifications
    #     outputs.overlays.unstable-packages
    #   ];
    #   config = {
    #     allowUnfree = true;
    #   };
    # };

    home = {
      username = "cody";
      homeDirectory = "/home/cody";
    };

    # Config files
    xdg.configFile = {
      fish = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/fish/.config/fish";
      };

      nvim = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/nvim/.config/nvim";
      };

      "starship.toml" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/starship/.config/starship.toml";
      };
    };

    # Home files
    home.file = {
      ".tmux.conf" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/tmux/.tmux.conf";
      };

      ".wezterm.lua" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/wezterm/.wezterm.lua";
      };
    };

    home.packages = with pkgs; [
      # headless
      btop
      dwt1-shell-color-scripts
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

      # gui
      discord-ptb
      obsidian
      slack
      tidal-hifi
      vivaldi

      gnomeExtensions.hide-top-bar
    ];

    programs = {
      git = {
        enable = true;
      };

      starship = {
        enable = true;
      };

      wezterm = {
        enable = true;
      };
    };

    # 4k screen configs
    xresources.properties = {
      "Xcursor.size" = 16;
      "Xft.dpi" = 172;
    };

    # Reload systemd when changing configs
    # systemd.user.startServices = "sd-switch";

    home.stateVersion = "25.05";
  };
}
