return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  config = function(_, opts)
    require("rose-pine").setup({
      styles = {
        transparency = true,
      },
    })
    vim.cmd("colorscheme rose-pine")
  end
}
