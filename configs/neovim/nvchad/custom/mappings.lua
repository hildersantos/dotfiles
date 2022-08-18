local M = {}

M.todocomments = {
  n = {
    ["<leader>ft"] = {"<cmd> TodoTelescope <CR>", "find todos"},
  },
}

M.lsp_telescope = {
  n = {
    ["<leader>fs"] = {"<cmd> Telescope lsp_document_symbols <CR>", "find document symbols"},
    ["<leader>fS"] = {"<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", "find workspace symbols"},
  },
}

return M
