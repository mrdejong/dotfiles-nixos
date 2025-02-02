{ lib, pkgs, ... }:

let
  colors = import ../theming/colors.nix;
in
{
  # # steam-run for codeium-vim
  # # start nvim in bash first time, so the spell files can be downloaded
  # programs.zsh.shellAliases = {
  #   vim = "${pkgs.steam-run}/bin/steam-run nvim";
  #   nvim = "${pkgs.steam-run}/bin/steam-run nvim";
  # };
  environment.systemPackages = with pkgs; [
    nodejs
    go
  ];
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    autoCmd = [
      {
        event = "VimEnter";
        command = "set nofoldenable";
        desc = "Unfold All";
      }
      {
        event = "BufWrite";
        command = "%s/\\s\\+$//e";
        desc = "Remove Whitespaces";
      }
      {
        event = "FileType";
        pattern = [ "markdown" "org" "norg" ];
        command = "setlocal conceallevel=2";
        desc = "Conceal Syntax Attribute";
      }
      {
        event = "FileType";
        pattern = [ "markdown" "org" "norg" ];
        command = "setlocal spell spelllang=en,nl";
        desc = "Spell Checking";
      }
      {
        event = "FileType";
        pattern = [ "markdown" "org" "norg" ];
        command = ":TableModeEnable";
        desc = "Table Mode";
      }
      {
        event = "FileType";
        pattern = [ "markdown" ];
        command = "setlocal scrolloff=30";
        desc = "Fixed cursor location on markdown (for preview)";
      }
    ];

    options = {
      number = true;
      relativenumber = true;
      hidden = true;
      foldlevel = 99;
      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      expandtab = true;
      autoindent = true;
      wrap = false;
      scrolloff = 5;
      sidescroll = 40;
      completeopt = ["menu" "menuone" "noselect"];
      pumheight = 15;
      fileencoding = "utf-8";
      swapfile = false;
      timeoutlen = 2500;
      conceallevel = 3;
    };

    colorschemes.onedark = {
      enable = true;
      package = pkgs.vimPlugins.onedarkpro-nvim;
    };

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      {
        key = "<C-s>";
        action = "<CMD>w<CR>";
        options.desc = "Save";
      }
      {
        mode = "i";
        key = "jk";
        action = "<Esc>";
        options.desc = "Exit insert";
      }
      {
        mode = "i";
        key = "jw";
        action = "<Esc><CMD>w<CR>";
        options.desc = "Exit insert";
      }
      {
        key = "<leader>s";
        action = "<CMD>w<CR>";
        options.desc = "Save";
      }
      {
        key = "<leader>q";
        action = "<CMD>q<CR>";
        options.desc = "quit";
      }
      {
        key = "<F2>";
        action = "<CMD>Neotree toggle<CR>";
        options.desc = "Toggle NeoTree";
      }
      {
        key = "<leader>e";
        action = "<CMD>Neotree toggle<CR>";
        options.desc = "Toggle NeoTree";
      }
      {
        key = "<leader>fs";
        action = "<CMD>Neotree toggle<CR>";
        options.desc = "Toggle NeoTree";
      }
      {
        key = "<F3>";
        action = "<CMD>UndotreeToggle<CR>";
        options.desc = "Toggle Undotree";
      }
      {
        key = "<leader>sh";
        action = "<C-w>s";
        options.desc = "Split Horizontal";
      }
      {
        key = "<leader>sv";
        action = "<C-w>v";
        options.desc = "Split Vertical";
      }
      {
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Select Window Below";
      }
      {
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Select Window Above";
      }
      {
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Cycle Between Windows";
      }
      {
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Cycle Between Windows";
      }
      {
        key = "<leader>bb";
        action = "<CMD>BufferPick<CR>";
        options.desc = "View Open Buffer";
      }
      {
        key = "<leader>bc";
        action = "<CMD>BufferClose<CR>";
        options.desc = "View Open Buffer";
      }
      {
        key = "<leader>bn";
        action = "<CMD>:bnext<CR>";
        options.desc = "Next Buffer";
      }
      {
        key = "<leader>bp";
        action = "<CMD>:bprev<CR>";
        options.desc = "Previous Buffer";
      }
      {
        key = "<tab>";
        action = "<CMD>:bnext<CR>";
        options.desc = "Next Buffer";
      }
      {
        key = "<S-tab>";
        action = "<CMD>:bprev<CR>";
        options.desc = "Previous Buffer";
      }
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options.desc = "Tab Text Right";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options.desc = "Tab Text Left";
      }
      {
        mode = "n";
        key = "<C-/>";
        action = "<Plug>(comment_toggle_linewise_current)";
        options.desc = "(Un)comment in Normal Mode";
      }
      {
        mode = "v";
        key = "<C-/>";
        action = "<Plug>(comment_toggle_linewise_visual)";
        options.desc = "(Un)comment in Visual Mode";
      }
      {
        mode = "n";
        key = "<C-S-/>";
        action = "<Plug>(comment_toggle_blockwise_current)";
        options.desc = "(Un)comment in Normal Mode";
      }
      {
        mode = "v";
        key = "<C-S-/>";
        action = "<Plug>(comment_toggle_blockwise_visual)";
        options.desc = "(Un)comment in Visual Mode";
      }
      {
        mode = "n";
        key = "gd";
        action = "<CMD>lua vim.lsp.buf.hover()<CR>";
      }
      {
        mode = "n";
        key = "gD";
        action = "<CMD>lua vim.lsp.buf.definition()<CR>";
      }
      {
        mode = "n";
        key = "ge";
        action = "<CMD>lua vim.diagnostic.open_float()<CR>";
      }
      {
        mode = "n";
        key = "<leader>r";
        action = ":! ";
      }
    ];

    plugins = {
      lualine.enable = true;
      barbar.enable = true;
      gitgutter.enable = true;
      indent-blankline = {
        enable = true;
        scope.enabled = true;
      };
      lastplace.enable = true;
      comment-nvim.enable = true;
      fugitive.enable = true;
      markdown-preview.enable = true;
      nvim-autopairs.enable = true;
      telescope = {
        enable = true;
        extraOptions = {
          pickers.find_files = {
            hidden = true;
          };
        };
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
        };
      };
      neo-tree = {
        enable = true;
        window.width = 30;
        closeIfLastWindow = true;
        extraOptions = {
          filesystem = {
            filtered_items = {
              visible = true;
            };
          };
        };
      };
      undotree = {
        enable = true;
        focusOnToggle = true;
        highlightChangedText = true;
      };
      treesitter = {
        enable = true;
        nixvimInjections = true;
        folding = false;
        indent = true;
        nixGrammars = true;
        ensureInstalled = "all";
        incrementalSelection.enable = true;
      };
      treesitter-refactor = {
        enable = true;
      };
      nvim-colorizer = {
        enable = true;
        userDefaultOptions = {
          css = true;
          tailwind = "both";
        };
      };
      neorg = {
        enable = true;
        lazyLoading = true;
        modules = {
          "core.defaults".__empty = null;
          "core.dirman".config = {
            workspaces = {
              notes = "~/notes";
            };
            default_workspace = "notes";
          };
          "core.concealer".__empty = null;
          "core.completion".config.engine = "nvim-cmp";
        };
      };
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          nixd.enable = true;
          #svelte.enable = true;
          #html.enable = true;
          #cssls.enable = true;
          #tsserver.enable = true;
          #pyright.enable = true;
          gopls.enable = true;
        };
      };
      lspkind = {
        enable = true;
        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buffer]";
            orgmode = "[orgmode]";
            neorg = "[neorg]";
          };
        };
      };
      lsp-lines.enable = true;
      luasnip.enable = true;
      cmp_luasnip.enable = true;
      cmp-nvim-lsp.enable = true;
      nvim-cmp = {
        enable = true;
        snippet.expand = "luasnip";
        mapping = {
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          # "<Tab>" = {
          #   modes = ["i" "s"];
          #   action = "cmp.mapping.select_next_item()";
          # };
          # "<S-Tab>" = {
          #   modes = ["i" "s"];
          #   action = "cmp.mapping.select_prev_item()";
          # };
          "<Down>" = {
            modes = ["i" "s"];
            action = "cmp.mapping.select_next_item()";
          };
          "<Up>" = {
            modes = ["i" "s"];
            action = "cmp.mapping.select_prev_item()";
          };
          "<C-j>" = {
            modes = ["i" "s"];
            action = "cmp.mapping.select_next_item()";
          };
          "<C-k>" = {
            modes = ["i" "s"];
            action = "cmp.mapping.select_prev_item()";
          };
          # "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = "cmp.mapping.confirm({ select = true })";
        };
        sources = [
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {name = "path";}
          {name = "buffer";}
          {name = "nvim_lua";}
          {name = "orgmode";}
          {name = "neorg";}
        ];
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      luasnip
      friendly-snippets
      orgmode
      vim-table-mode
      vim-cool
      # codeium-vim
      (pkgs.vimUtils.buildVimPlugin rec {
        pname = "scope-nvim";
        version = "cd27af77ad61a7199af5c28d27013fb956eb0e3e";
        src = pkgs.fetchFromGitHub {
          owner = "tiagovla";
          repo = "scope.nvim";
          rev = version;
          sha256 = "sha256-z1ytdhxKrLnZG8qMPEe2h+wC9tF4K/x6zplwnIojZuE=";
        };
      })
      (pkgs.vimUtils.buildVimPlugin rec {
        pname = "org-bullets.nvim";
        version = "6e0d60e901bb939eb526139cb1f8d59065132fd9";
        src = pkgs.fetchFromGitHub {
          owner = "akinsho";
          repo = "org-bullets.nvim";
          rev = version;
          sha256 = "sha256-x6S4WdgfUr7HGEHToSDy3pSHEwOPQalzWhBUipqMtnw=";
        };
      })
    ];
    extraConfigLua = ''
      require("luasnip.loaders.from_vscode").lazy_load()
      require('orgmode').setup({
        org_agenda_files = { '~/org/**/*' },
        org_default_notes_file = '~/org/refile.org',
      })
      vim.cmd[[
        augroup orgmode_settings
          autocmd!
          autocmd FileType org
          \ setlocal conceallevel=2 |
          \ setlocal concealcursor=nc
        augroup END
      ]]

      require('org-bullets').setup()
    '';
    extraConfigLuaPre = with colors.scheme.default.hex; ''
      require('orgmode').setup_ts_grammar()
      require('onedarkpro').setup({
        colors = {
          bg = "#${bg}",
        }
      })
    '';
  };
}
