{
  description = "Impact Font";

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { flake-compat, flake-utils, nixpkgs, self }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        version = "1.0.0";
      in
      {
        packages.default = with pkgs; stdenv.mkDerivation {
          name = "impact-${version}";
          src = ./.;
          buildInputs = [ unzip ];
          installPhase = ''
            unzip $src/Impact-Font.zip
            install -m444 -Dt $out/share/fonts/truetype *.ttf
          '';
        };
      });
}
