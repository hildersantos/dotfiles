local M = {}

M.todocomments = {
  n = {
    ["<leader>ft"] = {"<cmd> TodoTelescope <CR>", "find todos"},
  },
}

M.truzen = {
  n = {
    ["<leader>ta"] = { "<cmd> TZAtaraxis <CR>", "   truzen ataraxis" },
    ["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "   truzen minimal" },
    ["<leader>tf"] = { "<cmd> TZFocus <CR>", "   truzen focus" },
  },
}

M.lsp_telescope = {
  n = {
    ["<leader>fs"] = {"<cmd> Telescope lsp_document_symbols <CR>", "find document symbols"},
    ["<leader>fS"] = {"<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", "find workspace symbols"},
  },
}

return M
