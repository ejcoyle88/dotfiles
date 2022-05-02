vim.api.nvim_command([[
augroup update_vimrc
  autocmd BufWritePre $MYVIMRC lua require('core.utils').ReloadConfig()
augroup END
]])


vim.api.nvim_command([[
augroup close_vimtree
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
augroup END
]])
