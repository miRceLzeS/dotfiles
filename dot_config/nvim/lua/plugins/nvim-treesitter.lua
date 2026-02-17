return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "c",
      "cpp",
      "go",
      "python",
      "rust",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
  },
  opts_extend = { "ensure_installed" },
  config = function(_, opts)
    local TS = require("nvim-treesitter")
    TS.setup(opts)
    TS.install(opts.ensure_installed)
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end
    })
  end
}
