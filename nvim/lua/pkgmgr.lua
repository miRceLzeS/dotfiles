-- Import lazy.nvim as plugins/packages manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
    	"clone",
    	"--filter=blob:none",
    	"https://github.com/folke/lazy.nvim.git",
    	"--branch=stable", -- latest stable release
    	lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." }
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- Add all other plugins here
local plugins = {
	-- colorscheme plugin
	{
		"xero/miasma.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- fallback on error
			local name = "miasma"
			local status, err = pcall(vim.cmd, "colorscheme " .. name)
			if not status then
				vim.notify("colorscheme " .. name .. " not found: " .. err)
				vim.cmd('colorscheme default')
			end
		end
	}
}

-- lazy.nvim will load them here
require("lazy").setup(plugins, {})