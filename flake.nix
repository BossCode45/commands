{
    description = "YATwm";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    };
    outputs = { self, nixpkgs, ... }@inputs:
        let pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
          {
              devShells.x86_64-linux.default = pkgs.mkShell {
                  buildInputs = with pkgs; [
                      gcc
                      gnumake
                      clang-tools
                  ];
              };
              packages.x86_64-linux.libCommands =  (pkgs.callPackage ./libCommands.nix {});
              packages.x86_64-linux.default = self.packages.x86_64-linux.libCommands;
          };
}
