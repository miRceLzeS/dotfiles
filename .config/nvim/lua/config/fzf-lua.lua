local function opts_default(keymap_desc)
  return { noremap = true, silent = true, desc = keymap_desc }
end

return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<CR>", mode = { "n", "v" }, opts_default("switch files") },
    { "<leader>fb", "<cmd>FzfLua buffers<CR>", mode = { "n", "v" }, opts_default("switch buffers") },
    { "<leader>fl", "<cmd>FzfLua live_grep<CR>", mode = { "n", "v" }, opts_default("live grep") },
    { "<leader>fk", "<cmd>FzfLua keymaps<CR>", mode = { "n", "v" }, opts_default("keymaps") },
    { "<leader>f:", "<cmd>FzfLua command_history<CR>", mode = { "n", "v" }, opts_default("check command history") },
  },
}
