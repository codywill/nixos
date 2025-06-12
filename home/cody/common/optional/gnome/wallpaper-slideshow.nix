{pkgs, ...}: {
  home.packages = with pkgs; [
    gnomeExtensions.wallpaper-slideshow
  ];
}


