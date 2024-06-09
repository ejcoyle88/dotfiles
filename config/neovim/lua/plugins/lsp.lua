return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(_, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({buffer = bufnr})
      end)
    end
  },
  { 'williamboman/mason.nvim' },
  "mfussenegger/nvim-dap",
  "jay-babu/mason-nvim-dap.nvim",
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    }
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      local lsp_zero = require('lsp-zero')
      local mason = require('mason')
      local masondap = require('mason-nvim-dap')
      mason.setup({})
      masondap.setup({})
      require('mason-lspconfig').setup({
        handlers = {
          lsp_zero.default_setup,
          rust_analyzer = function() end,
        }
      })
    end
  },
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = 'copilot', group_index = 2 },
          { name = 'nvim_lsp', group_index = 2 },
          { name = 'path', group_index = 2 },
          { name = 'luasnip', group_index = 2 },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item()),
          ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item()),
          ["<C-Tab>"] = cmp.mapping(function(fallback)
            -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if not entry then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              end
              cmp.confirm()
            else
              fallback()
            end
          end, {"i","s","c",}),
        })
      })
    end
  },
  {'L3MON4D3/LuaSnip'},
  {
    'zbirenbaum/copilot.lua',
    config = function()
      require('copilot').setup({})
    end
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require("copilot_cmp").setup()
    end
  },
}
