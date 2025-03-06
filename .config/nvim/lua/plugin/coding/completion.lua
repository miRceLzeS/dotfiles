return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    version = "*",
    event = "InsertEnter",
    config = function()
      local lspconfig = require("lspconfig")
      local blink = require("blink.cmp")
      local lspconfig_defaults = lspconfig.util.default_config

      lspconfig_defaults.capabilities = vim.tbl_deep_extend(
        "force",
        lspconfig_defaults.capabilities,
        blink.get_lsp_capabilities()
      )
      blink.setup({
        keymap = {
          preset = "none",
          ["<CR>"] = { "accept", "fallback" },
          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },
          ["<C-k>"] = { "scroll_documentation_up", "fallback" },
          ["<C-j>"] = { "scroll_documentation_down", "fallback" },
        },
        -- cmdline = {
        --   keymap = {
        --     preset = "none",
        --     ["<CR>"] = { "accept", "fallback" },
        --     ["<Tab>"] = { "select_next", "fallback" },
        --     ["<S-Tab>"] = { "select_prev", "fallback" },
        --   },
        -- },
        sources = {
          default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
          }
        },
        snippets = {
          preset = "luasnip",
        },
        completion = {
          keyword = {
            range = "full",
          },
          accept = {
            auto_brackets = {
              enabled = true,
            },
          },
          list = {
            selection = {
              preselect = function(ctx)
                return ctx.mode ~= "cmdline"
              end,
              auto_insert = true,
            },
            cycle = {
              from_top = true,
              from_bottom = true,
            }
          },
          menu = {
            border = "single",
            -- nvim-cmp style menu
            draw = {
              columns = {
                { "label",     "label_description", gap = 1 },
                { "kind_icon", "kind",              gap = 1 },
              }
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 100,
            window = {
              border = "single",
            },
          },
          -- virtual text auto insert
          ghost_text = {
            enabled = true,
          },
        },
        -- experiment
        signature = {
          enabled = false,
          window = {
            border = "sigle",
          }
        },
      })
    end
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --     "L3MON4D3/LuaSnip",
  --     "saadparwaiz1/cmp_luasnip",

  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-cmdline",
  --     "hrsh7th/cmp-path",
  --   },
  --   event = "InsertEnter",
  --   config = function()
  --     local lspconfig = require("lspconfig")

  --     local luasnip = require('luasnip')

  --     local cmp_nvim_lsp = require("cmp_nvim_lsp")
  --     local cmp = require("cmp")

  --     local lspconfig_defaults = lspconfig.util.default_config
  --     lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  --       "force",
  --       lspconfig_defaults.capabilities,
  --       cmp_nvim_lsp.default_capabilities()
  --     )

  --     cmp.setup({
  --       snippet = {
  --         expand = function(args)
  --           require("luasnip").lsp_expand(args.body)
  --         end,
  --       },
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp" },
  --         { name = "luasnip" },
  --       }, {
  --         { name = "buffer" },
  --       }),
  --       window = {
  --         documentation = {
  --           border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  --         },
  --         completion = {
  --           border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  --           winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
  --         },
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ["<cr>"] = cmp.mapping.confirm({ select = true }),
  --         -- Super tab
  --         ["<tab>"] = cmp.mapping(function(fallback)
  --           local col = vim.fn.col(".") - 1

  --           if cmp.visible() then
  --             cmp.select_next_item({ behavior = "select" })
  --           elseif luasnip.expand_or_locally_jumpable() then
  --             luasnip.expand_or_jump()
  --           elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
  --             fallback()
  --           else
  --             cmp.complete()
  --           end
  --         end, { "i", "s" }),

  --         -- Super shift tab
  --         ["<S-Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_prev_item({ behavior = "select" })
  --           elseif luasnip.locally_jumpable(-1) then
  --             luasnip.jump(-1)
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --       })
  --     })

  --     cmp.setup.cmdline({ "/", "?" }, {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = cmp.config.sources({
  --         { name = "buffer" }
  --       })
  --     })

  --     cmp.setup.cmdline(":", {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = cmp.config.sources({
  --         { name = "path" }
  --       }, {
  --         { name = "cmdline" }
  --       }),
  --       matching = { disallow_symbol_nonprefix_matching = false }
  --     })
  --   end,
  -- },
}
