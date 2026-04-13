#!/usr/bin/env bash
set -euo pipefail

OS_NAME="$(uname -s)"
DEFAULT_HOST="linux"
if [ "$OS_NAME" = "Darwin" ]; then
  DEFAULT_HOST="$(scutil --get LocalHostName 2>/dev/null || hostname -s)"
fi

HM_HOST="${1:-$DEFAULT_HOST}"       # flake host name
NIXCFG="${NIXCFG:-$HOME/nix-config}"
SHELLS_FILE="/etc/shells"

echo "[*] Using flake: $NIXCFG#$HM_HOST"

# 1) Install Nix if missing (Determinate Systems)
if ! command -v nix >/dev/null 2>&1; then
  echo "[*] Nix not found. Installing via Determinate Systems..."
  curl -fsSL https://install.determinate.systems/nix \
    | sh -s -- install --determinate

  echo "[*] Nix installed. Start a new shell (log out / log in) and run this script again."
  exit 0
fi

# 2) Apply config from flake
if [ "$OS_NAME" = "Darwin" ]; then
  ZSH_PATH="/run/current-system/sw/bin/zsh"
  echo "[*] Applying nix-darwin config..."
  nix run nix-darwin/master#darwin-rebuild -- switch --flake "$NIXCFG#$HM_HOST"
else
  ZSH_PATH="$HOME/.nix-profile/bin/zsh"
  echo "[*] Applying Home Manager config..."
  nix run home-manager/master -- switch --flake "$NIXCFG#$HM_HOST"
fi

# 3) Make Nix zsh a valid login shell and chsh
echo "[*] Setting up zsh as login shell (if available)..."
if [ -x "$ZSH_PATH" ]; then
  if ! grep -qx "$ZSH_PATH" "$SHELLS_FILE"; then
    echo "[*] Adding $ZSH_PATH to $SHELLS_FILE (sudo)..."
    echo "$ZSH_PATH" | sudo tee -a "$SHELLS_FILE" >/dev/null
  fi

  if [ "${SHELL:-}" != "$ZSH_PATH" ]; then
    echo "[*] Changing login shell to $ZSH_PATH ..."
    chsh -s "$ZSH_PATH"
  else
    echo "[*] Login shell is already $ZSH_PATH"
  fi
else
  echo "[!] $ZSH_PATH not found. Did you enable programs.zsh in your Home Manager config?"
fi

echo "[*] Done. Log out and log back in to use the new environment."
