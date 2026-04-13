#
# Darwin (macOS) system configuration for NixOS.
#

{ pkgs, ... }:

{
  # User configuration
  users.users.toku163 = {
    home = "/Users/toku163";
    shell = pkgs.zsh;
  };

  # Enable experimental features for Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable zsh as the default shell
  programs.zsh.enable = true;

  system.primaryUser = "toku163";
  system.stateVersion = 6;
}
