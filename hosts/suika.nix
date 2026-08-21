{ ... }:

{
  # Homebrewのインポート
  imports = [
    ../modules/darwin/homebrew.nix
  ];
  networking.hostName = "suika";

  nix.enable = false;
}
