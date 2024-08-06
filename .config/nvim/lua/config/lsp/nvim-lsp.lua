return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.keymap.set( { "n", "v" } , "K", vim.lsp.buf.hover, { desc = "hover and display info" })
    vim.keymap.set( { "n", "v" } , "gd", vim.lsp.buf.definition, { desc = "go to definition" })
  end
}
