if g:os != "Windows"
	if empty(glob('~/.config/nvim/autoload/plug.vim'))
		silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall
		autocmd VimEnter * PlugInstall | source $MYVIMRC
	endif
else
	if empty(glob('C:\Users\vaeix\AppData\Local\nvim\autoload\plug.vim'))
		silent !curl -fLo C:\Users\vaeix\AppData\Local\nvim\autoload\plug.vim --create-dirs
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall
		autocmd VimEnter * PlugInstall | source $MYVIMRC
	endif
endif

call plug#begin('~/.config/nvim/autoload/plugged')
  Plug 'sheerun/vim-polyglot'
  Plug '907th/vim-auto-save'
  Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
  Plug 'junegunn/rainbow_parentheses.vim'
  Plug 'jremmen/vim-ripgrep'
  Plug 'tpope/vim-fugitive'
  Plug 'mbbill/undotree'
  Plug 'easymotion/vim-easymotion'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'morhetz/gruvbox'
  Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'tag': '0.1.155',
        \ 'do': 'bash install.sh',
        \ }
  Plug 'OmniSharp/omnisharp-vim'
  Plug 'puremourning/vimspector'
  Plug 'ionide/Ionide-vim', {
        \ 'do':  'make fsautocomplete',
        \}
  Plug 'vim-test/vim-test'
  Plug 'vimwiki/vimwiki'
  Plug 'pacha/vem-tabline'
  Plug 'mhinz/vim-startify'
call plug#end()

autocmd VimEnter *
	\ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\| PlugInstall --sync | q
	\| endif
