{pkgs, ...}: {
  services.xserver.desktopManager.gnome = {
    extraGSettingsOverridePackages = [pkgs.mutter];
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['variable-refresh-rate']
    '';
  };
}
