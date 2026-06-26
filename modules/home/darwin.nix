#
# Darwin (macOS) home configuration for Nix Home Manager.
#

{ hostName, lib, ... }:

{
  # Home Manager configuration for Darwin (macOS) systems.
  home.username = "toku163";
  home.homeDirectory = "/Users/toku163";

  home.sessionVariables = {
    HM_HOST = hostName;
  };

  # zsh alias for updating the configuration and applying changes with darwin-rebuild
  programs.zsh = {
    shellAliases = {
      nup = ''git -C "$NIXCFG" add -A && sudo darwin-rebuild switch --flake "$NIXCFG#${hostName}"'';
      nup-i = ''git -C "$NIXCFG" add -A && sudo darwin-rebuild switch --flake "$NIXCFG#${hostName}" --impure'';
      ncode = ''code "$NIXCFG"'';
      nz = ''zed "$NIXCFG"'';
    };
  };

  # for darwin, MacVim is used instead of Vim, so we disable the Vim configuration.
  programs.vim.enable = lib.mkForce false;
}
