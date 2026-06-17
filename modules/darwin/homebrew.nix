#
# Homebrew configuration for Darwin (macOS) systems.
#

{ ... }:

{
  homebrew = {
    enable = true;

    # automatic updates and upgrades when activating the configuration
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };

    # brews and casks to be installed
    brews = [
      "colima"
      "docker"
      "docker-compose"
      "typst"
      "llvm"
    ];

    casks = [
      "arc"
      "visual-studio-code"
      "1password"
      "1password-cli"
      "raycast"
      "alt-tab"
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
      "scroll-reverser"
      "codex-app"
      "google-drive"
      "cyberduck"
      "zed"
    ];
  };
}
