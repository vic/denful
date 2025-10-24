# denful - Dendritic Nix modules, enough to fill a den.

Denful provides lots of [flake.parts](https://flake.parts/) modules that you can mix in your existing [Dendritic](https://vic.github.io/dendrix/Dendritic.html) configurations.

## Features

* no need for nix wizardy. designed for beginners but your magic is of great use here.
* minimalistic and inter-operable tools. incrementally enable just what you need.
* supports all nix module classes. no special cases.
* multi host definitions with high module re-use.
* multi user support.
* secrets management.
* automatic website documentation. 
* experimental: flake-agnostic. can be used with or without flakes/flake.parts.

## Facets 

You are free to cherry-pick any of our provided modules via `flake.modules.<class>.<name>`.

However, we also provide higher modules (named **facets**). The concept is similar to that of _layers_ in
editor-configurations like Spacemacs or plugin-bundles in other editor distributions.

### `facet`s definition.

This section is mostly useful for facet authors, but surely is of value for facet users.
The following example just tries to show a facet structure and what it can do.

Syntax here is that of [`flake.aspects`](https://github.com/vic/flake-aspects).
resolved modules are be available at `flake.modules.<class>.niri-desktop`
but people can also use `flake.aspects.niri-desktop` if desired (eg, as an aspect dependency).

```nix
# facets/niri.nix
{ inputs, lib, ... }:
{
  flake.aspects.niri = { aspects, ... }: {
    description = ''
      Niri: a scrollable-tiling WM (https://github.com/YaLTeR/niri)

      Configured via https://github.com/sodiboo/niri-flake.
    '';

    # the `flake` class module contributes to your flake,
    # for example by adding inputs or caches via `github:vic/flake-file`.
    flake = {
      flake-file.inputs.niri-flake = {
        url = lib.mkDefault "github:sodiboo/niri-flake";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      flake-file.nixConfig = {
        extra-substituters = [ "https://niri.cachix.org" ];
        extra-trusted-public-keys = [ "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" ];
      };

      # it can also import aditional flake modules.
      # flake-file.inputs.foo-dep.url = "...";
      # imports = [ inputs.foo-dep.flakeModule ];

      # or define/enhance another aspect: anarchy is our omarchy like aspect.
      flake.aspects.anarchy = {
        includes = [ aspects.niri ];
      };
    };

    # the nixos class enhances os-level stuff for the `niri` aspect.
    nixos = {
      imports = [ inputs.niri-flake.nixosModules.niri ];
    };
  };
}
```

### `facet` usage

In some dendritic module of yours: 

```nix
{ inputs, ... }:
{
  imports = [ inputs.denful.modules.flake.niri ];
  flake.aspects.my-laptop = {aspects, ...}: {
    includes = [ aspects.anarchy ];
  };
}
```

