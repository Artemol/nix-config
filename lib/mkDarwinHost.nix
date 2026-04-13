{ self, nix-darwin, home-manager-darwin }:

{ hostName
, system ? "aarch64-darwin"
, hostModules ? [ ]
, homeModules ? [ ]
}:

nix-darwin.lib.darwinSystem {
  inherit system;

  modules =
    [
      ../modules/darwin/base.nix
    ]
    ++ hostModules
    ++ [
      home-manager-darwin.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit hostName;
        };
        home-manager.users.toku163.imports =
          [
            ../home/common.nix
            ../modules/home/darwin.nix
          ]
          ++ homeModules;

        system.configurationRevision = self.rev or self.dirtyRev or null;
      }
    ];
}
