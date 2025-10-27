{ inputs, ... }:
{
  vix.aspects.denful = {
    flake = { };
  };

  vix.aspects.import-tree.provides.hosts = {
    description = ''
      ### Automatic import of host's nixos/darwin modules.

      #### Usage Examples

        # modules/hosts/default.nix
        { denful, ... }:
        {
          imports = [ denful.vix.facet ];
        }

      #### Arguments

        hostPath: A path.

      #### Aspect behaviour

      this aspect hooks into `den.aspects.default.host` and 
      for each host, it will import-tree all nix files:

         ''${hostsPath}/''${host.name}/_''${host.class}/**/*.nix

      each nix file is part of the corresponding class: nixos/darwin.
    '';

    __functor =
      _:
      { hostsPath }:
      { host }:
      let
        path = "${hostsPath}/${host.name}/_${host.class}";
        imported = {
          name = path;
          description = "import-tree ${path}";
          ${host.class}.imports = [ (inputs.import-tree path) ];
        };
      in
      if builtins.pathExists path then imported else { };
  };
}
