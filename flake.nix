{
  description = "Impact Font";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        version = "1.0.0";
      in
      {
        defaultPackage = with pkgs; stdenv.mkDerivation {
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
