return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local cfg = require("nvim-treesitter.configs")
      cfg.setup({
        ensure_installed = { "lua", "go", "rust", "cpp" },
        highlight = { enable = true },
        indent = { enable = true },
      })
      vim.api.nvim_set_hl(0, "@variable", { italic = false, bold = false, fg = "#e0def4" })
      vim.api.nvim_set_hl(0, "@property", { italic = false, bold = false, fg = "#e0def4" })
      vim.api.nvim_set_hl(0, "@function.call", { italic = false, bold = true, fg = "#ebbcba" })
      vim.api.nvim_set_hl(0, "@function.method", { italic = false, bold = true, fg = "#c4a7e7" })
      vim.api.nvim_set_hl(0, "Keyword", { italic = true, fg = "#31748f" })
    end,
  },
}
