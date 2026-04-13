{ pkgs, ... }:

{
  networking.hostName = "bergamot";

  users.users.toku163 = {
    home = "/Users/toku163";
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;

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

  # brewでインストールするアプリケーションの設定
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };

    brews = [
      "colima"
      "docker-compose"
      "typst"
    ];

    casks = [
      "arc"
      "visual-studio-code"
      "1password"
      "raycast"
      "alt-tab"
      "chatgpt"
      "clipy"
      "dotnet-sdk"
      "linear-linear"
      "google-japanese-ime"
      "font-hackgen-nerd"
      "mactex"
      "scroll-reverser"
      "unity-hub"
      "zotero"
    ];
  };

  system.primaryUser = "toku163";
  system.stateVersion = 6;
}
