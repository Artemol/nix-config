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
      push = {
        autoSetupRemote = true;
      };
    };
  };

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
  };

  # inject the WezTerm configuration file into the home directory
  home.file.".config/wezterm".source = ./wezterm;

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
    shellAliases = {
      ".." = "cd ..";
      cd = "z";
    };
    zsh-abbr = {
      enable = true;
      abbreviations = {
        ga = "git add";
        gc = "git commit";
        gpl = "git pull";
        gps = "git push";
        gst = "git status";
        br = "brew";
        v = "vim";
        nv = "nvim";
        ssh-p = "ssh -oPreferredAuthentications=password -oPubkeyAuthentication=no";
      };
    };
    # zsh configuration files to be sourced
    initContent = builtins.readFile ./zshrc;
    envExtra = builtins.readFile ./zshenv;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      username = {
        style_user = "white bold";
        style_root = "black bold";
        format = "[$user]($style)";
        disabled = false;
        show_always = true;
      };
      hostname = {
        ssh_only = false;
        format = "@[$hostname](white bold)[$ssh_symbol](bold blue) ";
        disabled = false;
      };
    };
    enableZshIntegration = true;
  };

  programs.lazygit = {
    enable = true;
    settings = {
      # git.pagers.externalDiffCommand = "difft --color=always";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.lsd = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.difftastic.enable = true;
  programs.fzf.enable = true;
  programs.ripgrep.enable = true;
  programs.go.enable = true;
  programs.uv.enable = true;

  # 追加のパッケージがあればー
  home.packages = with pkgs; [ 
    curl tree wget htop ghq devenv
  ];
}
