{ config, pkgs, lib, ... }:

{
  home.username = "toku163";
  home.homeDirectory = "/Users/toku163";

  home.sessionVariables = {
    HM_HOST = "bergamot";
  };

  programs.zsh = {
    shellAliases = {
      nup = ''git -C "$NIXCFG" add -A && sudo darwin-rebuild switch --flake "$NIXCFG#$HM_HOST"'';
      nup-i = ''git -C "$NIXCFG" add -A && sudo darwin-rebuild switch --flake "$NIXCFG#$HM_HOST" --impure'';
      ncode = ''code "$NIXCFG"'';
    };
    initContent = builtins.readFile ./zshrc;
    envExtra = builtins.readFile ./zshenv;
  };

  programs.vim = {
    enable = lib.mkForce false;
  };
}
