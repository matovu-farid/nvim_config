local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.g.user_emmet_leader_key = '<C-z>'
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration
  'dyng/ctrlsf.vim',
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP

      { 'nvim-lua/plenary.nvim' },
      {
        'akinsho/flutter-tools.nvim',
        lazy = false,
        dependencies = {
          'nvim-lua/plenary.nvim',
          'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
      }, { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
      {
        "akinsho/toggleterm.nvim",
        config = function()
          require("toggleterm").setup({
            direction = 'right',
          })
        end
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },
  'tpope/vim-rails',
  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  { 'honza/vim-snippets' },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },
  { 'hrsh7th/cmp-path' },
  { "onsails/lspkind.nvim" },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end

  },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup {
        debounce_delay = 20000,
      }
    end,
  },
  { "lewis6991/gitsigns.nvim" },
  { "m4xshen/autoclose.nvim" },
  { 'christoomey/vim-tmux-navigator' },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    opts = {},
    config = function()
      require('which-key').setup {}
    end
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  { 'kristijanhusak/vim-dadbod-completion' },

  {
    -- Add a shades of purple theme
    'Rigellute/shades-of-purple.vim',
    -- config = function()
    --   vim.cmd.colorscheme 'shades_of_purple'
    -- end,

  },
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup({
        user_default_options = {
          css = true,
          css_fn = true,
          tailwind = true,
          mode = 'virtualtext'
        }
      })
    end
  },
  {
    'maxmx03/solarized.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = 'dark' -- or 'light'


      require('solarized').setup({
        theme = 'neo', -- or comment to use solarized default theme.
        enables = {
          editor = true,
          syntax = true,
          bufferline = true,
          cmp = true,
          diagnostic = true,
          dashboard = true,
          gitsign = true,
          hop = true,
          indentblankline = true,
          lsp = true,
          lspsaga = true,
          navic = true,
          neotree = true,
          notify = true,
          semantic = true,
          telescope = true,
          tree = true,
          treesitter = true,
          whichkey = true,
          mini = true, -- PLUGINS
        },
        styles = {
          comments = { italic = true, bold = false },
          functions = { italic = true },
          variables = { italic = false, },
        },
        colors = function(colors, colorhelper)
          local darken = colorhelper.darken
          local lighten = colorhelper.lighten
          local blend = colorhelper.blend

          return {
            fg = "#ffffff", -- output: #ffffff
            bg = darken(colors.base03, 10),
            blend = blend(colors.base03, colors.base00, 0.5),
          }
        end,
        highlights = function(colors)
          local c = colors
          return {
            Normal = { fg = colors.fg, bg = colors.bg },
            LineNr = { bg = colors.bg },
            CursorLineNr = { bg = colors.bg },
            SignColumn = { bg = colors.bg },
            VertSplit = { bg = "NONE", fg = "NONE" },
            Visual = { bg = c.base04 },
            CmpKindBorder = { fg = c.base01, bg = c.base04 }
          }
        end
      })
    end,

  },
  {'kevinhwang91/nvim-ufo', dependencies={'kevinhwang91/promise-async'}},

  {
    -- Theme inspired by Tokyonight
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'tokyonight'
      --
      require('tokyonight').setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        }

      })
    end,

  },
  { 'AhmedAbdulrahman/vim-aylin' },
  { 'Mofiqul/dracula.nvim' },
  { 'shaunsingh/nord.nvim' },
  { 'Th3Whit3Wolf/one-nvim' },
  { 'mhartington/oceanic-next' },
  {
    'projekt0n/github-nvim-theme',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({
        -- ...
      })

      vim.cmd('colorscheme github_dark')
    end,
  },
  -- {'natebosch/vim-lsc'},
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function()
      require("persistence").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({})
    end

  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
    },
  },
  { 'dart-lang/dart-vim-plugin' },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',    opts = {} },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  { 'Mohammed-Taher/AdvancedNewFile.nvim' },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim',      version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.



  
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
    {
      "echasnovski/mini.map",
      branch = "stable",
      config = function()
        require('mini.map').setup()
        local map = require('mini.map')
        map.setup({
          integrations = {
            map.gen_integration.builtin_search(),
            map.gen_integration.diagnostic({
              error = 'DiagnosticFloatingError',
              warn  = 'DiagnosticFloatingWarn',
              info  = 'DiagnosticFloatingInfo',
              hint  = 'DiagnosticFloatingHint',
            }),
          },
          symbols = {
            encode = map.gen_encode_symbols.dot('4x2'),
          },
          window = {
            side = 'right',
            width = 20, -- set to 1 for a pure scrollbar :)
            winblend = 15,
            show_integration_count = false,
          },
        })
      end
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate markdown markdown_inline',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },
  -- Github copilot
  { 'zbirenbaum/copilot.lua' },
  {
    -- Neotree
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",

      -- only needed if you want to use the commands with "_with_window_picker" suffix
      's1n7ax/nvim-window-picker',
      tag = "v1.*",
      config = function()
        require 'window-picker'.setup({
          popup_border_style = "rounded",
          autoselect_one = true,
          include_current = false,
          filter_rules = {
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { 'neo-tree', "neo-tree-popup", "notify" },

              -- if the buffer type is one of following, the window will be ignored
              buftype = { 'terminal', "quickfix" },
            },
          },
          other_win_hl_color = '#e35e4f',
        })
      end,

    },

    config = function()
      require("neo-tree").setup({
        source_selector = {
          winbar = false,
          statusline = true
        },
        auto_open = 0,

        use_libuv_file_watcher = true,
        close_if_last_window = true,

        buffers = {
          follow_current_file = true,
        },
        window = {
          position = "right",
          width = 30,
        },
        filesystem = {
          use_libuv_file_watcher = true,
          follow_current_file = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              "node_modules"
            },
            never_show = {
              ".DS_Store",
              "thumbs.db"
            },

          },
        },

      })
    end,


  },
  { 'mg979/vim-visual-multi' },
  { "tpope/vim-repeat" },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
        lastplace_open_folds = true
      })
    end,
  },
  { "mbbill/undotree" },
  { 'neovim/nvim-lspconfig' },
  { 'nvimtools/none-ls.nvim' },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",

    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  { 'MunifTanjim/prettier.nvim' },
  { 'maxmellon/vim-jsx-pretty' },
  { 'mfussenegger/nvim-dap' },
  {
    'theHamsta/nvim-dap-virtual-text'
  },
  {
    'rcarriga/nvim-dap-ui',
    config = function()
      require("neodev").setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
      })
    end
  },
  { "mxsdev/nvim-dap-vscode-js" },
  {
    'microsoft/vscode-js-debug',
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  },
  {
    "akinsho/bufferline.nvim",
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup {
        options = {
          separator_style = "slope",
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            if context.buffer:current() then
              return ''
            end

            return ''
          end,
        },
      }
    end
  },
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup({})
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    }
  },
  { "ThePrimeagen/harpoon" },
  -- { "mattn/emmet-vim" },

  { "rafamadriz/friendly-snippets" },

  { "rcarriga/nvim-notify" },
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        -- Optional, you don't have to run setup.
        groups = { -- table: default groups
          'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
          'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
          'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
          'SignColumn', 'CursorLineNr', 'EndOfBuffer', 'tabline', 'Pmenu',
          'TabLineFill', 'TabLineSel', 'TabLine', 'TabLineFill', 'TabLineSel',


        },
        extra_groups = {
          "NormalFloat",     -- plugins which have float panel such as Lazy, Mason, LspInfo
          "NvimTreeNormal",  -- NvimTree
        },                   -- table: additional groups that should be cleared
        exclude_groups = {}, -- table: groups you don't want to clear
      })
      require('transparent').clear_prefix('BufferLine')
      require('transparent').clear_prefix('NeoTree')
    end
  }

}, {})
