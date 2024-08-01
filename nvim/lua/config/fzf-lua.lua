return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {
        vim.keymap.set({ "n", "v" }, "<leader>ff", ":FzfLua files<CR>", { noremap = true, silent = true })
    },
}
