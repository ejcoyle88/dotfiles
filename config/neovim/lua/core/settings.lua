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

opt.shell = '/bin/zsh'
opt.path = table.concat({ '**' })
opt.wildmenu=true
opt.wildmode='longest:full,full'
opt.wildignore = add {
  '.bak', '.pyc', '.o', '.ojb', '.a', '.orig,',
  '.pdf','.jpg','.gif','.png','.jpeg',
  '.avi','.mkv','.so',
  '**/vendor/**',
  '**/node_modules/**',
  '**/bin/**',
  '**/obj/**',
  '*.DS_Store'
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
