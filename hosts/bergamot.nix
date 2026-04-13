{ pkgs, ... }:

{
  networking.hostName = "bergamot";

  users.users.toku163 = {
    home = "/Users/toku163";
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };

    casks = [
      "arc"
      "visual-studio-code"
    ];
  };

  system.primaryUser = "toku163";
  system.stateVersion = 6;
}
