local g = vim.g
local opt = vim.opt
local fn = vim.fn

local function add(value, str, sep)
  sep = sep or ','
  str = str or ''
  value = type(value) == 'table' and table.concat(value, sep) or value
  return str ~= '' and table.concat({ value, str }, sep) or value
end

g.syntax='on'

g.noerrorbells=true
g.hidden=true

opt.termguicolors=true
--cmd('colorscheme seoul256')

opt.background='dark'

opt.path = table.concat({ '**' })
opt.wildmenu=true
opt.wildmode='full'
opt.wildignore = add {
  '.bak,.pyc,.o,.ojb,.a,.orig,',
  '.pdf,.jpg,.gif,.png,.jpeg,',
  '.avi,.mkv,.so,',
  '**/vendor/**,',
  '**/node_modules/**,',
  '**/bin/**,',
  '**/obj/**'
}
opt.tabstop=2
opt.softtabstop=2
opt.shiftwidth=2
opt.expandtab=true
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

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
if fn.has("patch-8.1.1564") then
  -- Recently vim can merge signcolumn and number column into one
  opt.signcolumn='number'
else
  opt.signcolumn='yes'
end

