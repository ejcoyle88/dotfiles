local g = vim.g
local opt = vim.opt
local cmd = vim.cmd

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

local nnoremaps = function(lhs, rhs)
  nnoremap(lhs, rhs, { silent = true })
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

-- Shortcut to rapidly toggle `set list`
nnoremaps('<leader>l', ':set list!<cr>')

-- Normal/Visual tab for bracket pairs
nnoremap('<tab>', '%')
vnoremap('<tab>', '%')

-- :q and :wq close buffers
ex.abbrev('wq', 'w<bar>bd')
ex.abbrev('q', 'bd')
ex.abbrev('qq', 'quit')
ex.abbrev('wqq', 'w<bar>quit')

-- Bindings for swapping buffer next/prev.
nnoremaps('<leader>bl', ':Telescope buffers<CR>')
nnoremaps('<leader>bn', ':bn<CR>')
nnoremaps('<leader>bv', ':bp<CR>')
nnoremaps('<leader>bp', '<C-^>')
nnoremaps('<leader>bq', ':bp <BAR> bd #<CR>')
nnoremaps('<leader>bc', ':enew<CR>')
nnoremaps('<leader>bw', ':w<CR>')

-- Moving around files
nnoremaps('<leader>ff', ':Telescope find_files<CR>')
nnoremaps('<leader>fg', ':lua require"telescope-config".project_files()<CR>')
nnoremaps('<leader>ft', ':NvimTreeToggle<CR>')
nnoremaps('<leader>fl', ':NvimTreeFocus<CR>')

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

-- This makes j and k work as you would expect with wrapped lines,
-- while still working with the line numbers when making a jump
-- command
cmd[[nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')]]
cmd[[nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')]]

-- un-highlight search results
nnoremaps('<leader><leader>', ':noh<cr>')

-- Make search case insensitive by default
nnoremap('/', '/\\v')
vnoremap('/', '/\\v')

-- Make 'r' redo, because I never use 'replace' and <c-r> is
-- an awkward hand movement
nnoremap('r', '<c-r>')
