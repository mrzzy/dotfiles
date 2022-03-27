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

" show number, cursor and column guides
set number

" docs lookup
set keywordprg=:Man

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
Plug 'neoclide/coc.nvim', {'commit': '16e74f9b31d20b8dfc8933132beed4c175d824ea'}

" coc: tab completion
" check if char before cursor is whitespace or empty
function! s:is_space_empty() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>is_space_empty() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" coc: view docs
function! s:view_docs() abort
  " extract the current keyword as search keyword
  let keyword = expand('<cword>')
  try
    " lookup vim docs for keyword
    execute 'help ' . keyword
  catch
    if (coc#rpc#ready())
      " lookup coc engine for docs
      call CocActionAsync('doHover')
    else
      " lookup manpage for keyword
      execute &keywordprg . ' ' . keyword
    endif
  endtry
endfunction

nnoremap K :call <SID>view_docs()<CR>

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
