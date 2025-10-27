{ lib, config, ... }:
let
  denfulType = lib.types.submodule({ name, ... }: {
    freeformType = lib.types.attrsOf denfulType;
  });
in
{
  options.denful = lib.mkOption {
    type = denfulType;
    default = {};
  };
  config._module.args.denful = config.denful;
}