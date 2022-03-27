"
" dotfiles
" nvim config
"

" Editor
" tab expansion
set expandtab
set shiftwidth=2
set tabstop=2

" reduce for better responsiveness
set updatetime=300

" show no-visible characters
set list

" Plugins
call plug#begin()
" Plugins: Editor
" text editing
Plug 'tpope/vim-repeat', {'commit': '24afe922e6a05891756ecf331f39a1f6743d3d5a'}
Plug 'tpope/vim-surround', {'commit': '9857a874632d1b983a7f4b1c85e3d15990c8b101'}

" multi-subsitute command
Plug 'tpope/vim-abolish', {'commit': '3f0c8faadf0c5b68bcf40785c1c42e3731bfa522'}

" sensible key bindings
Plug 'tpope/vim-unimpaired', {'commit': 'f992923d336e93c7f50fe9b35a07d5a92660ecaf'}

" editor sessions
Plug 'tpope/vim-obsession', {'commit': 'd2818a614ec3a5d174c6bb19e87e2eeb207f4900'}

" auto alignment
Plug 'junegunn/vim-easy-align', {'commit': '12dd6316974f71ce333e360c0260b4e1f81169c3'}
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" code completion
Plug 'neoclide/coc.nvim', {'commit': '5830e03dc346d4502111a00c6c11cb5e44df5596'}

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
