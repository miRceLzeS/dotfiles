return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = "VeryLazy",
  -- early load treesitter if directly opening a file from cmd line
  lazy = vim.fn.argc(-1) == 0,
  init = function(plugin)
    -- folke's recommendation
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {
      "c",
      "lua",
      "vim",
      "python",
      "rust",
      "go",
    },
    hightlight = { enable = true },
    indent = { enable = true },
  },
}
