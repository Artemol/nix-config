#
# Darwin (macOS) system configuration for NixOS.
#

{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "zsh-abbr"
    ];

  # User configuration
  users.users.toku163 = {
    home = "/Users/toku163";
    shell = pkgs.zsh;
  };

  # Enable experimental features for Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable zsh as the default shell
  programs.zsh.enable = true;

  # nix-darwinによるMacOSの設定
  system = {
    defaults = {
      NSGlobalDomain.AppleShowAllExtensions = true;
      NSGlobalDomain.AppleShowAllFiles = true;
      NSGlobalDomain.ApplePressAndHoldEnabled = false; # キーの長押しでアクセントメニューを表示しない
      NSGlobalDomain.InitialKeyRepeat = 20; # キーリピートの初期遅延を短くする
      NSGlobalDomain.KeyRepeat = 5; # キーリピートの速度を速くする
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

  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };

  system.primaryUser = "toku163";
  system.stateVersion = 6;
}
