return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.1",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            hidden = true,
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          }
        }
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    end
  },
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = {"org"},
    config = function()
      require("orgmode").setup({
        org_agenda_files = "~/orgfiles/**/*",
        org_default_notes_file = "~/orgfiles/refile.org",
        org_capture_templates = {
          t = {
            description = "TODO",
            template = "* TODO %?\n SCHEDULED: %t",
            target = "~/orgfiles/refile.org"
          },
        }
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function ()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
          },
        },
      })

      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>')
      vim.keymap.set('n', '<leader>0', ':Neotree focus<CR>')
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
      })
    end
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        indent = {
          enable = true
          },
        line_num = {
          enable = true
        },
        chunk = {
          enable = true
        }
      })
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require('nvim-autopairs').setup({})
    end
  },
  {
    "saghen/blink.cmp",
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      sources = {
        default = {"lsp", "path", "snippets", "buffer"},
        per_filetype = {
          org = {"orgmode"},
        },
        providers = {
          orgmode = {
            name = "Orgmode",
            module = "orgmode.org.autocompletion.blink",
            fallbacks = {"buffer"},
          }
        }
      },
      keymap = {
        preset = "enter",
      }
    }
  },
  {
    "ixru/nvim-markdown",
    ft = {"markdown"},
  },
  {
    "romgrk/barbar.nvim",
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    version = '^1.0.0',
    init = function() vim.g.barbar_auto_setup = false end,
    config = function()
      require("barbar").setup({
        animation = true,
      })

      vim.keymap.set('n', '<leader>bn', ':BufferNext<CR>', { desc = "Next buffer" })
      vim.keymap.set('n', '<leader>bp', ':BufferPrevious<CR>', { desc = "Previous buffer" })
      vim.keymap.set('n', '<leader>bc', ':BufferClose<CR>', { desc = "Close buffer" })
      vim.keymap.set("n", "<leader>br", ":BufferRestore<CR>", { desc = "Restore buffer" })
    end
  },
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    version = "*",
    config = function()
      require("toggleterm").setup({})
      vim.keymap.set('n', '<leader>t', ':ToggleTerm direction=float<CR>', { desc = "Toggle Terminal" })
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    config = function()
      require("diffview").setup({})

      vim.keymap.set("n", "<leader>do", ":DiffviewOpen<CR>", { desc = "Open Diffview" })
      vim.keymap.set("n", "<leader>dc", ":DiffviewClose<CR>", { desc = "Close Diffview" })
    end
  },
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {},
    config = function()
      require("gitlinker").setup()

      vim.keymap.set("v", "<leader>gy", ":GitLink<CR>", { desc = "Yank Git link" })
      vim.keymap.set("v", "<leader>gY", ":GitLink!<CR>", { desc = "Open Git link" })
    end
  },
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    dependencies = {
      {
        "copilotlsp-nvim/copilot-lsp",
        init = function()
          vim.g.copilot_nes_debounse = 500
        end
      },
    },
    init = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
        },
        nes = {
          enabled = true,
          auto_trigger = true,
        },
        filetypes = {
          markdown = false,
          org = false,
          text = false,
        },
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuOpen",
        callback = function()
          vim.b.copilot_suggestion_hidden = true
        end
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuClose",
        callback = function()
          vim.b.copilot_suggestion_hidden = false
        end
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    event = {"BufReadPre", "BufNewFile"},
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          }
        },
        ts_server = {},
        gopls = {},
        zls = {},
      }

      vim.lsp.enable({
        "lua_ls",
        "ts_server",
        "gopls",
        "zls",
      })

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config[server] = config
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
          vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
        end,
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      picker = {
        enabled = true,
      }
    }
  }
}

