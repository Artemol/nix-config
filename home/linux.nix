{ config, pkgs, ... }:

{
  home.username = "artemol";
  home.homeDirectory = "/home/artemol";

  home.sessionVariables = {
    HM_HOST = "linux";
  };

  programs.zsh.shellAliases = {
    nup = ''git -C "$NIXCFG" add -A && home-manager switch --flake "$NIXCFG#$HM_HOST"'';
    nup-i = ''git -C "$NIXCFG" add -A && home-manager switch --flake "$NIXCFG#$HM_HOST" --impure'';
  };
}