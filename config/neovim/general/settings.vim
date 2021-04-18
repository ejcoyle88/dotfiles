syntax on

set noerrorbells
set hidden

set termguicolors
autocmd vimenter * ++nested colorscheme gruvbox

set background=dark

set path+=**
set wildmenu
set wildmode=longest,list
set wildignore+=.bak,.pyc,.o,.ojb,.a,.orig
set wildignore+=.pdf,.jpg,.gif,.png,.jpeg,
set wildignore+=.avi,.mkv,.so,
set wildignore+=**/vendor/**
set wildignore+=**/node_modules/**
set wildignore+=**/bin/**
set wildignore+=**/obj/**

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set scrolloff=10

set showcmd
set clipboard+=unnamed

set pastetoggle=<F6>

set hlsearch
set incsearch
set wrapscan
set smartcase
set ignorecase
set gdefault

set smartindent
set autoindent

set wrap
set linebreak
set textwidth=0
set wrapmargin=0

set foldmethod=syntax
set foldnestmax=2

set number
set relativenumber
set cursorline

set noswapfile
set nobackup
set nowritebackup
set undodir=~/.config/nvim/undodir
set undofile

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

"if !(exists("+termguicolors") && &termguicolors)
  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"endif

let g:coc_global_extensions=['coc-omnisharp']

let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_selector_ui = 'fzf'

let g:rnvimr_ex_enable= 1
set shell=bash

let g:OmniSharp_popup_options = {
      \ 'winblend': 30,
      \ 'winhl': 'Normal:Normal'
      \}

let g:OmniSharp_popup_position="peek"

if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  " Highlight the completion documentation popup background/foreground the same as
  " the completion menu itself, for better readability with highlighted
  " documentation.
  set completepopup=highlight:Pmenu,border:off
else
  set completeopt=longest,menuone,preview
  " Set desired preview window height for viewing documentation.
  set previewheight=5
endif

let g:OmniSharp_selector_ui = 'fzf'
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets = [ 'netcoredbg']

highlight ColorColumn ctermbg=magenta guibg=magenta
call matchadd('ColorColumn', '\%81v.', 100)

if has('nvim') && exists('*nvim_open_win')
	augroup FSharpShowTooltip
		autocmd!
		"autocmd CursorHold *.fs,*.fsi,*.fsx call fsharp#showTooltip()
	augroup END
endif

if executable('rg')
  let g:rg_derive_root='true'
endif

augroup cmdGroup
  autocmd!
  au FocusLost * :wa

  au FileType json setlocal conceallevel=0
augroup END

function! HLNext (blinktime)
  let target_pat = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction

set matchtime=2
set matchpairs+=<:>
set showmatch

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

let g:vimwiki_list = [{'path': '~/.config/vimwiki',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

autocmd! BufWritePost ~/.config/nvim/** nested source ~/.config/nvim/init.vim
