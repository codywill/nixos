{
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./devtools
    ./docker
    ./goodix-fingerprint
    ./noctalia-greeter
    ./nvidia-gpu
  ];

  system.stateVersion = "26.05";

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs outputs;};
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config.allowUnfree = true;
  };

  devtools.enable = true;

  networking.networkmanager.enable = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  time.timeZone = "America/Los_Angeles";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.greetd = {
      enableGnomeKeyring = true;
      fprintAuth = lib.mkForce false;
    };
    pam.services.noctalia = {
      fprintAuth = true;
      enableGnomeKeyring = true;
    };
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing.enable = true;
    pulseaudio.enable = false;
    tailscale.enable = true;
  };

  programs.niri.enable = true;

  noctalia-greeter.enable = true;

  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
}
