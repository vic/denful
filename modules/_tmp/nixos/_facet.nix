{ inputs, lib, ... }:
name:
let
  inherit (inputs.flake-aspects.lib lib) new-scope;
  mkFacet =
    name:
    { config, ... }:
    {
      _module.args.denful.${name} = config.${name}.aspects;
      imports = [ (new-scope name) ];
      flake.modules.flake.${name} = {
        _module.args.denful.${name} = config.${name}.aspects;
        imports = [ (config.${name}.modules.flake.denful or { }) ];
      };
    };
in
{

  _module.args.denful.foo = { };

}
