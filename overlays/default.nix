{inputs, ...}: {
  additions = final: _prev: import ../pkgs final.pkgs;
  modifications = final: prev: {};
  unstable-packages = final: _prev: {
    unsstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
