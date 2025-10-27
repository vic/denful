{ lib, ... }: 
let
  denful-lib = { 
    dup = x : x * 2;
  };
in
{
  config.denful.lib = denful-lib;
  options.denful.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = {};
  };
}