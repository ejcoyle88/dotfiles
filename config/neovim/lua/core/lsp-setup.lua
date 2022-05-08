local status_ok, configs = pcall(require, "nvim-lsp-setup")
if not status_ok then
  return
end

local api = vim.api
local opts = { noremap=true, silent=true }

local nbufkeymap = function(bufnr, key, bind)
  api.nvim_buf_set_keymap(bufnr, 'n', key, bind, opts)
end

configs.setup({
  servers = {
    bashls = {},
    cssls = {},
    dockerls = {},
    fsautocomplete = {},
    grammarly = {},
    graphql = {},
    jsonls = {},
    omnisharp = {},
    pylsp = {},
    sumneko_lua = {},
    terraformls = {},
    vimls = {}
  },
  on_attach = function(_, bufnr)
    api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    nbufkeymap(bufnr, '<leader>gs', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    nbufkeymap(bufnr, '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    nbufkeymap(bufnr, '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    nbufkeymap(bufnr, '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    nbufkeymap(bufnr, '<leader>ch', '<cmd>lua vim.lsp.buf.hover()<CR>')
    nbufkeymap(bufnr, '<leader>cs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    nbufkeymap(bufnr, '<leader>cd', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    nbufkeymap(bufnr, '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>')
    nbufkeymap(bufnr, '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    nbufkeymap(bufnr, '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    nbufkeymap(bufnr, '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    nbufkeymap(bufnr, '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    nbufkeymap(bufnr, '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
  end
})
