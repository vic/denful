{ inputs, lib, config, ... }:
let
  mainModule = { imports = [ (inputs.import-tree ./modules) ]; };
  denful = lib.evalModules { modules = [ mainModule ]; };
in {
  imports = [ mainModule ];
}
