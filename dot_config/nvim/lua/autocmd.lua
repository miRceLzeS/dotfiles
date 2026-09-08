local keymap = require("keymap")

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
      require("nvim-treesitter").update()
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local lsp = vim.lsp

    local client = lsp.get_client_by_id(ev.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end

    keymap.del({ "n", "x" }, "gra")
    keymap.del({ "n", "x" }, "gri")
    keymap.del({ "n", "x" }, "grn")
    keymap.del({ "n", "x" }, "grr")
    keymap.del({ "n", "x" }, "grt")
    keymap.del({ "n", "x" }, "grx")
    keymap.del({ "n", "x" }, "g0")
    keymap.del({ "i" }, "<C-s>")
    keymap.del({ "n" }, "K", { buf = ev.buf })
    keymap.map({ "n", "x" }, "<M-r>", lsp.buf.rename)
    keymap.map({ "n", "x" }, "<Leader>uh", lsp.buf.hover)

    if client and client.server_capabilities.inlayHintProvider then
      keymap.map({ "n", "x" }, "<Leader>ui", function()
        lsp.inlay_hint.enable(
          not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }),
          { bufrn = ev.buf }
        )
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)

    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
