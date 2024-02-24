{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "fosto";
  home.homeDirectory = "/home/fosto";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
	  "electron-25.9.0"
  ];
  home.packages = with pkgs; [
  neofetch
  floorp
  helix # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  wget
  findutils
  discord
  brave
  floorp
  steam
  libreoffice-qt
  texstudio
  (texlive.combine { inherit (texlive) scheme-medium amsmath chemformula geometry wrapfig colortbl; })
  hunspell
  hunspellDicts.uk_UA
  hunspellDicts.it_IT
  openvpn
  networkmanager-openvpn
  nodejs
  protonvpn-cli_2
  quickemu
  minecraft
  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/fosto/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "floorp";
    SYS_MONITOR = "btop";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.emacs.enable = true;
  #services.emacs.enable = true;
  programs.ripgrep.enable = true; #sembra non workare
  programs.gh.enable = true;
  services.kdeconnect.enable = true;
  programs.java.enable = true;
  #programs.texlive.enable = true;
  programs.btop = {
    enable = true;
  };
  programs.git = {
    enable = true;
    #userName = "fostopern";
    #userEmail = "fostopern@tuta.io";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
    };
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      comment-nvim
      gruvbox-nvim
      neodev-nvim
      nvim-cmp
      telescope-nvim
      telescope-fzf-native-nvim
      cmp_luasnip
      cmp-nvim-lsp
      luasnip
      friendly-snippets
      lualine-nvim
      nvim-web-devicons

      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-vim
        p.tree-sitter-bash
        p.tree-sitter-lua
        p.tree-sitter-python
        p.tree-sitter-json
        
      ]))

      
      vim-nix
    ];
    
  };
}
