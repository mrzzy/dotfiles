"
" dotfiles
" nvim config
" completion engine
"

" coc: completion engine
function! Install_coc_extensions(info) abort
  " install or update coc extensions
  if a:info.status == "installed"
    CocInstall -sync coc-json@1.4.1
    CocInstall -sync coc-yaml@1.7.5
    CocInstall -sync coc-pyright@1.1.232
    CocInstall -sync coc-html@1.6.1
    CocInstall -sync coc-css@1.3.0
  elseif a:info.status == "updated"
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
" populate location list instead of CocList with diagnostics
let g:coc_enable_locationlist=1

" coc: code text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
