# bergamot (Mac Studio)

{ ... }:

{
  # Homebrewのインポート
  imports = [
    ../modules/darwin/homebrew.nix
  ];

  # hostnameの設定
  networking.hostName = "bergamot";

  # nix-darwinによるMacOSの設定
  system = {
    defaults = {
      NSGlobalDomain.AppleShowAllExtensions = true;
      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
      };
      dock = {
        autohide = true;
        show-recents = false;
      };
    };
  };
}
