#
# Darwin (macOS) home configuration for Nix Home Manager.
#

{ config, hostName, lib, ... }:

{
  # Home Manager configuration for Darwin (macOS) systems.
  home.username = "toku163";
  home.homeDirectory = "/Users/toku163";

  # Prepended to PATH in this order, for login and non-login shells alike.
  home.sessionPath = [
    "/Applications/MacVim.app/Contents/bin"
    "${config.home.homeDirectory}/.local/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "/Applications/Obsidian.app/Contents/MacOS"
    "/Applications/WezTerm.app/Contents/MacOS"
  ];

  home.sessionVariables = {
    HM_HOST = hostName;
    HOMEBREW_PREFIX = "/opt/homebrew";
    HOMEBREW_CELLAR = "/opt/homebrew/Cellar";
    HOMEBREW_REPOSITORY = "/opt/homebrew";
  };

  # Use the Bitwarden agent locally, but keep the agent forwarded by sshd
  # (ForwardAgent=yes) when logged in to this machine over SSH.
  home.sessionVariablesExtra = ''
    if [ -z "''${SSH_CONNECTION-}" ]; then
      export SSH_AUTH_SOCK="${config.home.homeDirectory}/.bitwarden-ssh-agent.sock"
    fi
  '';

  programs.zsh = {
    # fpath is a shell variable, so set it in .zshrc before compinit (order 570).
    initContent = lib.mkOrder 550 ''
      fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
    '';
    # zsh alias for updating the configuration and applying changes with darwin-rebuild
    shellAliases = {
      nup = ''git -C "$NIXCFG" add -A && sudo darwin-rebuild switch --flake "$NIXCFG#${hostName}"'';
      nup-i = ''git -C "$NIXCFG" add -A && sudo darwin-rebuild switch --flake "$NIXCFG#${hostName}" --impure'';
      nfu = ''nix flake update nixpkgs-darwin home-manager-darwin nix-darwin --flake "$NIXCFG"'';
      ncode = ''code "$NIXCFG"'';
      nz = ''zed "$NIXCFG"'';
    };
  };

  # for darwin, MacVim is used instead of Vim, so we disable the Vim configuration.
  programs.vim.enable = lib.mkForce false;
}
