local g = vim.g
local opt = vim.opt

local map = require('core.utils').map

local nnoremap = function(lhs, rhs, opts)
  map('n', lhs, rhs, opts)
end

local inoremap = function(lhs, rhs, opts)
  map('i', lhs, rhs, opts)
end

local vnoremap = function(lhs, rhs, opts)
  map('v', lhs, rhs, opts)
end

local ex = setmetatable({}, {
    __index = function(t, k)
      local command = k:gsub("_$", "!")
      local f = function(...)
        return vim.api.nvim_command(table.concat(vim.tbl_flatten {command, ...}, " "))
      end
      rawset(t, k, f)
      return f
    end
  });

-- Toggle auto-indent before clipboard paste
opt.pastetoggle='<leader>p'

-- Don't use Ex mode, use Q for formatting.
-- Revert with ":unmap Q".
-- map Q gq

-- Shortcut to rapidly toggle `set list`
nnoremap('<leader>l', ':set list!<cr>', { silent = true })

-- Normal/Visual tab for bracket pairs
nnoremap('<tab>', '%')
vnoremap('<tab>', '%')

-- :q and :wq close buffers
ex.abbrev('wq', 'w<bar>bd')
ex.abbrev('q', 'bd')
ex.abbrev('qq', 'quit')
ex.abbrev('wqq', 'w<bar>quit')

-- Bindings for swapping buffer next/prev.
nnoremap('gt', ':bnext<CR>')
nnoremap('gT', ':bprevious<CR>')

-- Open a new buffer
nnoremap('<leader>t', ':enew<CR>')
-- close a buffer
nnoremap('<leader>q', ':bp <BAR> bd #<CR>')
-- list buffers
nnoremap('<leader>bl', ':ls<CR>')

-- Set working directory
nnoremap('<leader>.', ':lcd %:p:h<CR>')

-- Forcing myself to learn to use HJKL. :(
nnoremap('<up>', '<nop>')
nnoremap('<down>', '<nop>')
nnoremap('<left>', '<nop>')
nnoremap('<right>', '<nop>')
inoremap('<down>', '<nop>')
inoremap('<left>', '<nop>')
inoremap('<right>', '<nop>')
inoremap('<up>', '<nop>')

-- Forcing down and up to make more sense
nnoremap('k', 'gk')
nnoremap('j', 'gj')

nnoremap('n', 'n:call HLNext(0.1)<cr>', { silent = true })
nnoremap('N', 'N:call HLNext(0.1)<cr>', { silent = true })
-- un-highlight search results
nnoremap('<leader><leader>', ':noh<cr>', { silent = true })

nnoremap('/', '/\\v')
vnoremap('/', '/\\v')

map('n', '<leader>-', ':NvimTreeToggle<CR>', { silent = true })
map('n', '<leader>=', ':NvimTreeFocus<CR>', { silent = true })
