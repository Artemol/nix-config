# bergamot (Mac Studio)

{ ... }:

{
  # Homebrewのインポート
  imports = [
    ../modules/darwin/homebrew.nix
  ];

  # hostnameの設定
  networking.hostName = "bergamot";

  
}
