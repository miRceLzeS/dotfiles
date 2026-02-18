return {
  "neovim/nvim-lspconfig",
  event = vim.g.LazyFile,
  config = function()
    local lsp_servers = {
      "clangd",
      "gopls",
      "rust_analyzer",
    }
    vim.lsp.enable(lsp_servers)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local fzf = require("fzf-lua")
        -- use tree-sitter for highlighting
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.semanticTokensProvider then
          client.server_capabilities.semanticTokensProvider = nil
          client.server_capabilities.documentHighlightProvider = false
        end
        pcall(function()
          if vim.lsp.semantic_tokens and vim.lsp.semantic_tokens.stop then
            vim.lsp.semantic_tokens.stop(args.buf, client.id)
          end
        end)
        local keymaps = require("keymaps")
        local map = function(lhs, rhs)
          local lhs_full = "<localleader>" .. lhs
          keymaps.map("n", lhs_full, rhs, { buffer = args.buf })
        end
        local unmap = function(lhs)
          keymaps.unmap("n", lhs, { buffer = args.buf })
        end
        unmap("gd")
        unmap("gr")
        unmap("gD")
        map("d", fzf.lsp_definitions)
        map("D", fzf.lsp_typedefs)
        map("i", fzf.lsp_implementations)
        map("m", fzf.lsp_workspace_diagnostics)
        map("r", fzf.lsp_references)
        map("s", fzf.lsp_live_workspace_symbols)
        if client.supports_method("textDocument/inlayHint") then
          map("h", function()
            local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
            vim.lsp.inlay_hint.enable(not enabled, { bufnr = args.buf })
          end)
        end
      end,
    })
  end,
}

