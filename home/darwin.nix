{ config, pkgs, ... }:

{
  home.username = "toku163";
  home.homeDirectory = "/Users/toku163";

  home.sessionVariables = {
    HM_HOST = "darwin";
  };

  programs.zsh = {
    shellAliases = {
      nup = ''git -C "$NIXCFG" add -A && home-manager switch --flake "$NIXCFG#$HM_HOST"'';
      nup-i = ''git -C "$NIXCFG" add -A && home-manager switch --flake "$NIXCFG#$HM_HOST" --impure'';
    };
    initContent = builtins.readFile ./zshrc;
    envExtra = builtins.readFile ./zshenv;
  };
}
