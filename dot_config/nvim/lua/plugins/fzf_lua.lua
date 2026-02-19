return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  opts = {
    { "telescope", "hide" },
    hls = {
      preview_normal = "Normal",
    },
    previewers = {
      builtin = {
        syntax = true,
        treesitter = {
          -- relys on nvim-treesitter-context
          context = false,
          enabled = true,
          disabled = {},
        },
      },
    },
    winopts = {
      preview = {
        default = "builtin",
        layout = "horizontal",
        horizontal = "right:60%",
      },
    },
  },
  config = function(_, opts)
    local fzf = require("fzf-lua")
    fzf.setup(opts)
    local map = require("keymaps").map
    local function leader(s)
      return "<leader>" .. s
    end
    map({"n"}, leader("b"), function() fzf.buffers() end)
    map({"n"}, leader("d"), function() fzf.diagnostics_workspace() end)
    map({"n"}, leader("ff"), function()
      fzf.files({ cwd = vim.fn.expand("%:p:h") })
    end)
    map({"n"}, leader("fc"), function()
      fzf.files({ cwd = vim.fn.stdpath("config") })
    end)
    map({"n"}, leader("fF"), function() fzf.files() end)
    map({"n"}, leader("g"), function() fzf.live_grep() end)
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local argc = vim.fn.argc()
        local open_picker = false
        if argc == 0 then
          open_picker = true
        elseif argc == 1 then
          local arg0 = vim.fn.argv(0)
          if vim.fn.isdirectory(arg0) == 1 then
            open_picker = true
            cwd = arg0
          end
        end
        if (not open_picker) or (vim.bo.buftype ~= "") then
          return
        end
        vim.schedule(function()
          fzf.files(cwd and { cwd = cwd } or nil)
        end)
      end
    })
  end,
}
