{pkgs ? import <nixpkgs> {}, ...}: let
  python = pkgs.python3;
  pythonEnv = python.withPackages (p: [
    p.numpy
  ]);
in {
  default = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      alejandra
      git
      home-manager
      nix
      nixd
      ollama
      python
      pythonEnv
      uv
    ];

    shellHook = ''
      export UV_PYTHON_PREFERENCE="only-system";
      export UV_PYTHON=${python}
    '';
  };
}
