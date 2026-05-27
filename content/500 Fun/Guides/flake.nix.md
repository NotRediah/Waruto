---
dg-publish: true
tags:
  - linux/config
---


```
{
  description = "Phinni Flake";

  inputs = {
    # Stable (main system)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Add unstable for selective packages
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nh.url = "github:nix-community/nh";
    curd.url = "github:Wraient/curd";
    viu.url = "github:Benexl/viu";

    # Added inputs for Noctalia + Quickshell
    quickshell.url = "github:outfoxxed/quickshell";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia.inputs.quickshell.follows = "quickshell";  # link Noctalia to Quickshell
  };

  outputs = { self, nixpkgs, unstable, curd, viu, quickshell, noctalia, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      unstablePkgs = import unstable { inherit system; };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix

          ({ config, pkgs, ... }: {
            environment.systemPackages = [
              curd.packages.${system}.default
              viu.packages.${system}.default

              # Example: pull a few from unstable
              unstablePkgs.super-productivity
              unstablePkgs.mangayomi
              # Add Noctalia and Quickshell permanently
              quickshell.packages.${system}.default
            ];
          })
        ];
      };
    };
}

```