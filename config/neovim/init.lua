vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local g = vim.g
local wo = vim.wo
local bo = vim.bo
local opt = vim.opt
local fn = vim.fn
local cmd = vim.cmd

-- https://blog.devgenius.io/create-custom-keymaps-in-neovim-with-lua-d1167de0f2c2
-- https://oroques.dev/notes/neovim-init/
_G.map = function(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

_G.nnoremap = function(lhs, rhs, opts)
    map('n', lhs, rhs, opts)
end

_G.inoremap = function(lhs, rhs, opts)
    map('i', lhs, rhs, opts)
end

_G.vnoremap = function(lhs, rhs, opts)
    map('v', lhs, rhs, opts)
end

_G.nnoremaps = function(lhs, rhs)
    nnoremap(lhs, rhs, { silent = true })
end

_G.ex = setmetatable({}, {
    __index = function(t, k)
        local command = k:gsub("_$", "!")
        local f = function(...)
            return vim.api.nvim_command(table.concat(vim.tbl_flatten {command, ...}, " "))
        end
        rawset(t, k, f)
        return f
    end
});

local TAB_WIDTH = 2
bo.tabstop = TAB_WIDTH
bo.shiftwidth = TAB_WIDTH
bo.expandtab = true

wo.cursorline = true
wo.nu = true
wo.rnu = true

g.syntax='on'
g.noerrorbells=true
g.hidden=true

opt.scrolloff=10

opt.showcmd=true

opt.hlsearch=true
opt.incsearch=true
opt.wrapscan=true
opt.smartcase=true
opt.ignorecase=true
opt.gdefault=true

opt.smartindent = true
opt.autoindent = true

opt.wrap=true
opt.linebreak=true
opt.textwidth=0
opt.wrapmargin=0

opt.foldmethod="syntax"
opt.foldnestmax=2

opt.number=true
opt.relativenumber=true
opt.cursorline=true

opt.swapfile=false
opt.backup=false
opt.writebackup=false
opt.undodir= os.getenv( "HOME" ) .. "/.config/nvim/undodir"
opt.undofile=true

-- Give more space for displaying messages.
opt.cmdheight=2

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
opt.updatetime=300

-- Don't pass messages to |ins-completion-menu|.
opt.shortmess = table.concat({
    't', -- truncate file messages at start
    'A', -- ignore annoying swap file messages
    'o', -- file-read message overwrites previous
    'O', -- file-read message overwrites previous
    'T', -- truncate non-file messages in middle
    'f', -- (file x of x) instead of just (x of x
    'F', -- Don't give file info when editing a file
    's',
    'c',
    'W' -- Dont show [w] or written when writing
})

opt.signcolumn="auto"

opt.formatoptions = "l"
opt.formatoptions = opt.formatoptions
- "a" -- Auto formatting is BAD.
- "t" -- Don't auto format my code. I got linters for that.
+ "c" -- In general, I like it when comments respect textwidth
+ "q" -- Allow formatting comments w/ gq
- "o" -- O and o, don't continue comments
+ "r" -- But do continue when pressing enter.
+ "n" -- Indent past the formatlistpat, not underneath it.
+ "j" -- Auto-remove comments if possible.
- "2" -- I'm not in gradeschool anymore

-- Toggle auto-indent before clipboard paste
-- opt.pastetoggle='<leader>p'

-- Shortcut to rapidly toggle `set list`
nnoremaps('<leader>l', ':set list!<cr>')

-- Normal/Visual tab for bracket pairs
nnoremap('<tab>', '%')
vnoremap('<tab>', '%')

-- :q and :wq close buffers
ex.cabbrev('wq', 'w<bar>bd')
ex.cabbrev('q', 'bd')
ex.cabbrev('qq', 'quit')
ex.cabbrev('wqq', 'w<bar>quit')

-- Bindings for swapping buffer next/prev.
nnoremaps('<leader>bn', ':bn<CR>')
nnoremaps('<leader>bv', ':bp<CR>')
nnoremaps('<leader>bp', '<C-^>')
nnoremaps('<leader>bq', ':bp <BAR> bd #<CR>')
nnoremaps('<leader>bc', ':enew<CR>')
nnoremaps('<leader>bw', ':w<CR>')

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

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
