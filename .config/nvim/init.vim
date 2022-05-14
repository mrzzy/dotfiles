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

" show number
set number

" docs lookup
set keywordprg=:Man

" keyboard bindings default leader key
let mapleader=','
 
" 24-bit color goodness
set termguicolors

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
xmap <leader>= <Plug>(EasyAlign)
nmap <leader>= <Plug>(EasyAlign)

" code jumping
Plug 'junegunn/fzf', {'tag': '0.29.0'}
Plug 'junegunn/fzf.vim', {'commit': 'b23e4bb8f853cb9641a609c5c8545751276958b0'}
nmap <C-p> :GFiles<CR>
nmap <C-Space> :Buffers<CR>

" ctrl-/ to ripgrep
nmap <C-_> :Rg<CR>

" syntax highlighting
Plug 'sainnhe/gruvbox-material', {'tag': 'v1.2.3'}
let g:gruvbox_material_background = 'medium'
Plug 'sheerun/vim-polyglot'

" coc completion engine
function! Install_coc_extensions(info) abort
  " install or update coc extensions
  if a:info.status == "installed"
    CocInstall -sync coc-json@1.4.1
    CocInstall -sync coc-yaml@1.7.5
    CocInstall -sync coc-pyright@1.1.232
  else a:info.status == "updated"
    CocUpdateSync
  endif
endfunction

Plug 'neoclide/coc.nvim', {
\ 'commit': '16e74f9b31d20b8dfc8933132beed4c175d824ea',
\ 'do': function('Install_coc_extensions')
\}

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

" coc: code navigation
nmap gd <Plug>(coc-definition)
nmap gD <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
nnoremap <silent><nowait> <C-j>  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <C-k>  :<C-u>CocList -I symbols<cr>

" coc: code text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" git integration
Plug 'tpope/vim-fugitive', {'tag': 'v3.6'}
nmap <leader>cc :Git<CR>

" patch: https://github.com/neovim/neovim/issues/12587
" fix CursorHold performance issue
Plug 'antoinemadec/FixCursorHold.nvim'

call plug#end()

" Colorscheme
colorscheme gruvbox-material

" Autocmds
augroup init_vim
  " delete any existing autocmds to prevent autocmd spam
  autocmd!

  autocmd FileType gitcommit,gitrebase let g:gutentags_enabled=0
augroup end
