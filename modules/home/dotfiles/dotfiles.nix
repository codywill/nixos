{
  config,
  lib,
  ...
}: {
  # TODO: migrate dotfiles to nix
  options.dotfiles = {
    path = lib.mkOption {
      type = lib.types.path;
      description = "Path to dotfiles root";
    };

    configs = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Attrset of xdg config name to dotfiles-relative path";
    };
  };

  config.xdg.configFile =
    lib.mapAttrs (
      _name: relPath: {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.dotfiles.path}/${relPath}";
      }
    )
    config.dotfiles.configs;
}
