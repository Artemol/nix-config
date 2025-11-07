{ config, pkgs, ... }:

{
  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "67518760+Artemol@users.noreply.github.com";
        name = "Artemol";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./vimrc;
  };

  # 追加のパッケージがあれば
  home.packages = with pkgs; [ curl ];
}

