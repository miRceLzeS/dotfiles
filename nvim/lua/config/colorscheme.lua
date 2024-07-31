return {
    "xero/miasma.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        local status, _ = pcall(vim.cmd, "colorscheme miasma")
        if not status then
            vim.notify("colorscheme failed to load")
            return
        end
    end,
}
