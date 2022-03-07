"
" dotfiles
" nvim config
"

" Editor
" tab expansion
set expandtab
set shiftwidth=2
set tabstop=2

" show no-visible characters
set list

" Plugins
call plug#begin()
" Plugins: Editor
" text editing
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" multi-subsitute command
Plug 'tpope/vim-abolish'

" sensible key bindings
Plug 'tpope/vim-unimpaired'

" auto alignment
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" patch editor fixes: https://github.com/neovim/neovim/issues/12587
" fix CursorHold performance issue
Plug 'antoinemadec/FixCursorHold.nvim'

" Plugins: Utility
call plug#end()

" Autocmds
augroup init_vim
  " delete any existing autocmds to prevent autocmd spam
  autocmd!

  autocmd FileType gitcommit,gitrebase let g:gutentags_enabled=0
augroup end
