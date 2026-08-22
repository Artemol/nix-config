#
# Homebrew configuration for Darwin (macOS) systems.
#

{ ... }:

{
  homebrew = {
    enable = true;

    # automatic updates and upgrades when activating the configuration
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      extraFlags = [ "--verbose" ];
    };

    # brews and casks to be installed
    brews = [
      "colima"
      "docker"
      "docker-buildx"
      "docker-compose"
      "typst"
      "gdb"
      "herdr"
    ];

    casks = [
      "arc"
      "visual-studio-code"
      "1password"
      "1password-cli"
      "bitwarden"
      "raycast"
      "chatgpt"
      "clipy"
      "dotnet-sdk"
      "linear"
      "google-japanese-ime"
      "font-hackgen-nerd"
      "mactex"
      "scroll-reverser"
      "unity-hub"
      "zotero"
      "jordanbaird-ice"
      "obsidian"
      "slack"
      "discord"
      "macvim-app"
      "notion"
      "microsoft-office"
      "microsoft-teams"
      "codex-app"
      "google-drive"
      "cyberduck"
      "zed"
      "dockdoor"
      "obs"
      "blender"
      "gimp"
      "zoom"
    ];
  };
}
