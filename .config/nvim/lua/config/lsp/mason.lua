return {
  { 
    "williamboman/mason.nvim", 
    lazy = false,
    -- cmd = "Mason",
    -- keys = {
    --   { "<leader>m", "<cmd>Mason<CR>", { noremap = true, silent = true }, desc = "Mason" },
    -- },
    config = function()
      require("mason").setup()
    end
  },
  { 
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "rust_analyzer",
          "gopls",
        }
      })
    end
  },
}
