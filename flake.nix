{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ] (system:
      let pkgs = import nixpkgs { inherit system; };
      in rec {
        packages = rec {
          all = pkgs.runCommand "xe-wallpapers" {
            nativeBuildInputs = with pkgs; [ imagemagick libjxl ];
            src = ./.;
          } ''
            cp -vrf $src/src .
            chmod -R a+w src
            ls -la
            mkdir -p $out src/jxl src/jpeg
            cd src
            make
            cp -vrf orig $out/orig
            cp -vrf jxl $out/jxl
            cp -vrf jpeg $out/jpeg
          '';
          jpeg = pkgs.runCommand "xe-wallpapers-jpeg" { src = ./.; } ''
            mkdir -p $out/share/backgrounds
            cp -vrf ${all}/jpeg/* $out/share/backgrounds
            cp -vrf $src/README.md $out/share/doc/xe-wallpapers
            cp -vrf $src/LICENSE $out/share/doc/xe-wallpapers
          '';
          jxl = pkgs.runCommand "xe-wallpapers-jxl" { src = ./.; } ''
            mkdir -p $out/share/backgrounds $out/share/doc/xe-wallpapers
            cp -vrf ${all}/jxl/* $out/share/backgrounds
            cp -vrf $src/README.md $out/share/doc/xe-wallpapers
            cp -vrf $src/LICENSE $out/share/doc/xe-wallpapers
          '';
          orig = pkgs.runCommand "xe-wallpapers-orig" { src = ./.; } ''
            mkdir -p $out
            cp -vrf $src/orig/* $out
          '';
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [ imagemagick libjxl nfpm tea gnupg ];
        };
      });
}
