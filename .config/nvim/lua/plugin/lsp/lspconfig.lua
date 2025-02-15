return {
  -- it is documented to follow the order
  -- ...
  -- require("mason").setup()
  -- require("mason-lspconfig").setup()
  -- require("lspconfig").xxx.setup {}
  -- ...
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    event = "VeryLazy",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BUfReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Triggerd when lsp attaches to buffer",
        callback = function(event)
          local mappings = {
            { "n",          "K",    ":lua vim.lsp.buf.hover()<cr>" },
            { "n",          "gd",   ":lua vim.lsp.buf.definition()<cr>" },
            { "n",          "gD",   ":lua vim.lsp.buf.declaration()<cr>" },
            { "n",          "gi",   ":lua vim.lsp.buf.implementation()<cr>" },
            { "n",          "gt",   ":lua vim.lsp.buf.type_definition()<cr>" },
            { "n",          "gr",   ":lua vim.lsp.buf.references()<cr>" },
            { "n",          "gs",   ":lua vim.lsp.buf.signature_help()<cr>" },
            { { "n", "x" }, "<F1>", ":lua vim.lsp.buf.format({async = true})<cr>" },
            { "n",          "<F2>", ":lua vim.lsp.buf.rename()<cr>" },
            { { "n", "x" }, "<F3>", ":lua vim.lsp.buf.code_action({async = true})<cr>" },
          }
          local shared_opts = { buffer = event.buf }

          for _, entry in ipairs(mappings) do
            local modes, lhs, rhs, entry_opts = unpack(entry)
            opts = vim.tbl_deep_extend("force", shared_opts, entry_opts or { silent = true })
            vim.keymap.set(modes, lhs, rhs, opts)
          end
        end,
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    event = { "BUfReadPost", "BufWritePost", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local signature = require("lsp_signature")

      -- lsp servers that should always be installed
      -- notice that the name of lsp servers are defined by nvim-lspconfigs
      -- thus the name appear in mason does not work
      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",
          "gopls",
          "rust_analyzer",
          "clangd",
        },
        automatic_installation = {
          exclude = {},
        },
        handlers = {
          -- automatically setup lsp servers with default config
          function(server_name)
            lspconfig[server_name].setup({
              on_attach = function(client, bufnr)
                -- function signature
                signature.on_attach({
                  hint_prefix = {
                    above = "↙ ",
                    current = "← ",
                    below = "↖ ",
                  },
                }, bufnr)
              end,
            })
          end,
        }
      })
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    lazy = true,
    enable = true,
  },
}
