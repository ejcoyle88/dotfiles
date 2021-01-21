GuiFont! Fira\ Mono:h12
GuiPopupmenu 0
GuiLinespace 1

call GuiWindowMaximized(1)

hi TermCursor cterm=reverse gui=reverse
inoremap <silent>  <S-Insert>  <C-R>+
