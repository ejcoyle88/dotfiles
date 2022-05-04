local status_ok, configs = pcall(require, "nvim-lsp-setup")
if not status_ok then
  return
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
  on_attach = function(client, bufnr)
    -- Disable autoformat on save
  end
})
