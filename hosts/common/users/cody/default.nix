{
  pkgs,
  config,
  ...
}: {
  users.users.cody = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [home-manager];
  };

  home-manager.users.cody = import ../../../../home/cody/${config.networking.hostName};
}
