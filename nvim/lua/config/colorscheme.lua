return {
	"xero/miasma.nvim",
	lazy = false,
	priority = 1000,

	-- error detect
	config = function()
		local colorscheme = "miasma"
		local status, err = pcall(vim.cmd, "colorscheme " .. colorscheme)
		if not status then
			vim.notify("colorscheme " .. name .. " not found: " .. err)
			vim.cmd('colorscheme default')
		return
		end
	end
}
