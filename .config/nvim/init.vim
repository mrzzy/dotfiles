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

" project wide search
nmap <C-_> :Rg<CR>
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

" syntax highlighting
let g:gruvbox_material_background = 'medium'
Plug 'sheerun/vim-polyglot'

" code completion
source ~/.config/nvim/completion.vim

" git integration
Plug 'tpope/vim-fugitive', {'tag': 'v3.6'}
nmap <leader>cc :Git<CR>

" undo history
Plug 'mbbill/undotree', {'tag': 'rel_6.1'}
nmap <leader>uu :UndotreeToggle<CR>

" window resizing
Plug 'simeji/winresizer' 
let g:winresizer_start_key='<leader>ww'

" project-specific file navigation
Plug 'tpope/vim-projectionist'

" patch: https://github.com/neovim/neovim/issues/12587
" fix CursorHold performance issue
Plug 'antoinemadec/FixCursorHold.nvim'

" Colorscheme
Plug 'sainnhe/gruvbox-material', {'tag': 'v1.2.3'}
nmap <leader>hl :set background=light<cr>
nmap <leader>hd :set background=dark<cr>

call plug#end()
" colorscheme plugin must be load before colorscheme can be set
colorscheme gruvbox-material

" Autocmds
augroup init_vim
  " delete any existing autocmds to prevent autocmd spam
  autocmd!

  autocmd FileType gitcommit,gitrebase let g:gutentags_enabled=0
augroup end
