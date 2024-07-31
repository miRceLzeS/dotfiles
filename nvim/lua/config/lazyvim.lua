return {
    vim.keymap.set({ "n", "v" }, "<leader><leader>", ":Lazy<CR>", { noremap = true, silent = true })
}
