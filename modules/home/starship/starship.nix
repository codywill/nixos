{
  config,
  lib,
  ...
}: let
  cfg = config.starship;
in {
  options.starship = {
    enable = lib.mkEnableOption "Use starship home config";
  };
  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = config.programs.fish.enable;

      settings = {
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$directory"
          "$git_branch"
          "$git_status"
          "$line_break"
          "$shell"
          "$python"
          "$nix_shell"
          "$character"
        ];

        username = {
          format = "[ $user]($style) ";
          detect_env_vars = ["SSH_CONNECTION"];
        };

        hostname = {
          ssh_only = true;
          ssh_symbol = " ";
          format = "[$ssh_symbol$hostname]($style) ";
          style = "bold green";
        };

        directory = {
          format = "[$read_only]($read_only_style)[$path]($style) ";
          read_only = " ";
        };

        git_branch = {
          format = "[$symbol$branch(:$remote_branch)]($style) ";
        };

        character = {
          success_symbol = "[➜](bold green) ";
          error_symbol = "[✗](bold red) ";
        };

        nix_shell = {
          symbol = "[](cyan)";
          format = "\${symbol}  [$name]($style) ";
        };

        python = {
          symbol = "[](yellow)";
          format = "(\${symbol}  [$virtualenv](blue) )";
        };
      };
    };
  };
}
