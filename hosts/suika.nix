{ pkgs, ... }:

{
  networking.hostName = "suika";

  users.users.toku163 = {
    home = "/Users/toku163";
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.nix-daemon.enable = true;
  programs.zsh.enable = true;

  system.primaryUser = "toku163";
  system.stateVersion = 6;
}
