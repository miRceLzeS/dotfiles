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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local lsp = vim.lsp
    local keymap = require("keymap")

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

    local on_list = function(opts)
      vim.fn.setqflist({}, " ", opts)
    end
    keymap.map({ "n", "x" }, "gr", function()
      lsp.buf.references(nil, { on_list = on_list })
      vim.cmd("copen")
    end)
    keymap.map({ "n", "x" }, "gd", function()
      lsp.buf.definition({ on_list = on_list })
      vim.cmd("copen")
    end)
    keymap.map({ "n", "x" }, "gD", function()
      lsp.buf.declaration({ on_list = on_list })
      vim.cmd("copen")
    end)
    keymap.map({ "n", "x" }, "gt", function()
      lsp.buf.type_definition({ on_list = on_list })
      vim.cmd("copen")
    end)
    keymap.map({ "n", "x" }, "gi", function()
      lsp.buf.implementation({ on_list = on_list })
      vim.cmd("copen")
    end)

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
