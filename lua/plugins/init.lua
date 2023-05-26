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
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',    opts = {} },
      { 'nvim-lua/plenary.nvim' },
      {
        'akinsho/flutter-tools.nvim',
        lazy = false,
        dependencies = {
          'nvim-lua/plenary.nvim',
          'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
      }, { "lukas-reineke/indent-blankline.nvim" },
      {
        "akinsho/toggleterm.nvim",
        config = function()
          require("toggleterm").setup({
            direction = 'float',

          })
        end
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

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
      require("auto-save").setup()
    end,
  },
  { "lewis6991/gitsigns.nvim" },
  { "m4xshen/autoclose.nvim" },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',   opts = {} },
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
  {
    -- Add a shades of purple theme
    'Rigellute/shades-of-purple.vim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'shades_of_purple'
    end,

  },

  {
    -- Theme inspired by Tokyonight
    'folke/tokyonight.nvim',
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme 'tokyonight'
    -- end,

  },
  -- {'natebosch/vim-lsc'},
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
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
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      show_trailing_blankline_indent = true,
    },
  },
  { 'dart-lang/dart-vim-plugin' },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',         opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

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
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        's1n7ax/nvim-window-picker',
        tag = "v1.*",
        config = function()
          require 'window-picker'.setup({
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
      }
    },

    config = function()
      require("neo-tree").setup({
        auto_open = 0,

        use_libuv_file_watcher = true,
        close_if_last_window = true,
        window = {
          width = 30,

        },
        buffers = {
          follow_current_file = true,
        },
        filesystem = {
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
            position = "right",

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
  { 'jose-elias-alvarez/null-ls.nvim' },
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
          separator_style = "slant",
        },
        

      }
    end
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" }
    }
  }





}, {})
