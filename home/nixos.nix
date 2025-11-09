{  config, pkgs, ... }:

{
  home.sessionVariables = {
    HM_HOST = "nixos";
  };

  programs.zsh.shellAliases = {
    nup = ''git -C "$NIXCFG" add -A && sudo nixos-rebuild switch --flake "$NIXCFG#$HM_HOST"'';
    nup-i = ''git -C "$NIXCFG" add -A && sudo nixos-rebuild switch --flake "$NIXCFG#$HM_HOST" --impure'';
  };
}