{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports =
    []
    ++ builtins.attrValues outputs.homeManagerModules;

  options = {
    # TODO: migrate dotfiles to nix
    dotfiles = lib.mkOption {
      type = lib.types.path;
      apply = toString;
      default = "${config.home.homeDirectory}/sources/codywill/dotfiles";
      example = "${config.home.homeDirectory}/sources/codywill/dotfiles";
      description = "Location of the dotfiles working directory";
    };
  };

  config = {
    nix = {
      package = lib.mkDefault pkgs.nix;
      settings = {
        experimental-features = ["nix-command" "flakes"];
        warn-dirty = false;
      };
    };

    # Config files
    xdg.configFile = {
      fish.source =
        config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/fish/.config/fish";

      nvim.source =
        config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/nvim/.config/nvim";

      "starship.toml".source =
        config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/starship/.config/starship.toml";
    };

    home = {
      username = "cody";
      homeDirectory = "/home/cody";

      # Home files
      file = {
        ".tmux.conf".source =
          config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/tmux/.tmux.conf";

        ".wezterm.lua".source =
          config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/wezterm/.wezterm.lua";
      };

      # TODO: move these to an import
      packages = with pkgs; [
        # headless
        btop
        dwt1-shell-color-scripts
        fastfetch
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
      ];
    };

    systemd.user.startServices = "sd-switch";

    programs = {
      git.enable = true;
      home-manager.enable = true;
      starship.enable = true;
      wezterm.enable = true;
    };
  };
}
