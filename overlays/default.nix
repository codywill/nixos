{
  inputs,
  outputs,
  ...
}: let
  addPatches = pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++ patches;
    });
in {
  flake-inputs = final: _: {
    inputs =
      builtins.mapAttrs (
        _: flake: let
          legacyPackages = (flake.legacyPackages or {}).${final.system} or {};
          packages = (flake.packages or {}).${final.system} or {};
        in
          if legacyPackages != {}
          then legacyPackages
          else packages
      )
      inputs;
  };

  stable = final: _: {
    stable = inputs.nixpkgs-stable.legacyPackages.${final.system};
  };

  additions = final: prev:
    import ../pkgs {pkgs = final;}
    // {
      # example = prev.example // import ../pkgs/example {pkgs = final;};
    };

  modifications = final: prev: {
    #  example = addPatches prev.example [./example.patch];
  };
}
