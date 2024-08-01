return {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    keys = {
        { "<leader>ff", ":FzfLua files<CR>", mode = { "n", "v" }, desc = "Fzf search files"},
        { "<leader>fb", ":FzfLua buffers<CR>", mode = { "n", "v" }, desc = "Fzf search buffers"},
    },
    config = function()
        local fzf = require("fzf-lua")
        fzf.setup({ "fzf-native" })
    end
}
