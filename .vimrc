set nocompatible " be iMproved, required

"--------- VUNDLE PLUGINS
filetype off 	 " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'guns/vim-clojure-static'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mhinz/vim-startify'
Plugin 'tpope/vim-obsession'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'PProvost/vim-ps1'
Plugin 'rking/ag.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'easymotion/vim-easymotion'

filetype plugin indent on " Required
"-------- VUNDLE PLUGINS 
"-------- INDENTATION
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
let g:jsx_ext_required = 0
"-------- INDENTATION
" Setup the theme
set background=dark
let g:gruvbox_termcolors = 256
let g:solarized_termcolors = 256
set t_Co=256
colorscheme gruvbox

set relativenumber " Show line numbers
syntax on " Turn on syntax highlighting
syntax sync minlines=256  " Makes big files slow
set synmaxcol=2048        " Also long lines are slow
set autoindent            " try your darndest to keep my indentation
set smartindent           " Be smarter about indenting dummy
set formatoptions=tcqr    " I like smart comments
set encoding=utf-8 " Use UTF8 encoded text
set mousehide " Hide the mouse when typing
set list " Show invisible characters
set backspace=2 " Backspace over eol, indent and insert
set scrolloff=3 " Start scrolling when im 3 lines from the top/bottom

set hlsearch              " highlight my search
set incsearch             " incremental search
set wrapscan              " Set the search scan to wrap around the file
set ignorecase            " when searching
set smartcase             " …unless I use an uppercase character

set foldmethod=marker " Fold on 3x{
set nofoldenable "But turn it off initially

" No backup or swap files
set nobackup
set nowritebackup
set noswapfile

" Set the leader key
let mapleader=','

" Key mappings
" Make regex sane
nnoremap / /\v

"Dumb escape
inoremap JJ <ESC>
vnoremap JJ <ESC>

" un-highlight search results
nnoremap <silent><leader><space> :noh<cr>

" Toggle auto-indent before clipboard paste
set pastetoggle=<leader>p

" Shortcut to rapidly toggle `set list`
nnoremap <silent><leader>l :set list!<cr>

" Normal/Visual tab for bracket pairs
nnoremap <tab> %
vnoremap <tab> %

"Opens a vertical split and switches over (,v)
nnoremap <leader>v <C-w>v<C-w>l

"Moves around split windows
nnoremap <leader>w <C-w><C-w>

"Close a window
nnoremap <silent><leader>q :q<cr>

" Close buffer
noremap <silent><leader>d :bd<cr>

" Buffer previous
noremap <silent><leader>z :bp<CR>

" Buffer next
noremap <silent><leader>x :bn<CR>

nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew %<CR>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR> 

" Indent highlight stuff
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_space_guides = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=none

"Timeout stuff
set timeout
set timeoutlen=2500
set ttimeoutlen=10

" Setup highlighting for braces
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Setup my status line
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Syntastic stuff
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

" Ignoring folders in CTRLP
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|(node_modules)|(DS_Store))$'

" Other CTRLP stuff
let g:ctrlp_max_files = 1000
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_cmd = 'CtrlP .'

" Forcing myself to learn to use HJKL. :(
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>

" Close VIM if NERDTree is the only thing left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTree Command Mappings
map <C-n> :NERDTreeToggle<CR>
"map <leader>t :NERDTreeToggle<cr>
nnoremap <leader>t :NERDTreeTabsToggle<cr>

" NERDTrees File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

