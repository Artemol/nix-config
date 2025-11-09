{ config, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {
  home.stateVersion = "25.05";

  home.sessionVariables = {
    NIXCFG = "${config.home.homeDirectory}/nix-config";
  };

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
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com";
        };
      };
      push = {
        autoSetupRemote = true;
      };
    };
  };

  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./vimrc;
  };

  programs.gh = {
    enable = true;
    settings = {
      aliases = {
        co = "pr checkout";
        v = "repo view --web";
      };
      git_protocol = "ssh";
    };
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
    };
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
    };
  };

  programs.starship = {
    enable = true;
  };

  # programs.go = { enable = true; };
  # programs.uv = { enable = true; };

  # 追加のパッケージがあれば
  # home.packages = with pkgs; [ 
    # curl tree wget htop
  # ];
}
