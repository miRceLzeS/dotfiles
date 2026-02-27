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
        local map = function(lhs, rhs, opts)
          local lhs_full = "<localleader>" .. lhs
          local options = { buffer = args.buf }
          if opts then
            options = vim.tbl_extend("force", options, opts)
          end
          keymaps.map("n", lhs_full, rhs, options)
        end
        local unmap = function(lhs)
          keymaps.unmap("n", lhs, { buffer = args.buf })
        end
        -- occurrence
        unmap("gd")
        unmap("gr")
        unmap("gD")
        map("d", fzf.lsp_definitions)
        map("D", fzf.lsp_typedefs)
        map("i", fzf.lsp_implementations)
        map("r", fzf.lsp_references)
        -- diagnostic
        map("m", fzf.lsp_workspace_diagnostics)
        -- symbol
        map("s", fzf.lsp_document_symbols)
        map("S", fzf.lsp_live_workspace_symbols)
        -- inlay hint
        if client.supports_method("textDocument/inlayHint") then
          map("h", function()
            local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
            vim.lsp.inlay_hint.enable(not enabled, { bufnr = args.buf })
          end)
        end
        -- hover
        unmap("K")
        map("k", function() vim.lsp.buf.hover() end)
        -- rename
        map("c", function() vim.lsp.buf.rename() end)
      end,
    })
  end,
}

