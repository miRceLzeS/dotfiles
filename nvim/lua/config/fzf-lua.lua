return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
  	dependencies = { "nvim-tree/nvim-web-devicons" },
  	config = function()
		-- calling `setup` is optional for customization
		local fzf_lua = require("fzf-lua")
		fzf_lua.setup({
			winopts = { row = 1, col = 0 },
		})
		vim.keymap.set("n", "<leader>ff", fzf_lua.files,		{ desc = "Fzf files" } )
		vim.keymap.set("n", "<leader>fb", fzf_lua.buffers,		{ desc = "Fzf buffers" } )
		vim.keymap.set("n", "<leader>ft", fzf_lua.tabs,			{ desc = "Fzf tabs" } )
	end
}
