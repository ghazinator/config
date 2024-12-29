set nocompatible
syntax enable
filetype plugin indent on

set expandtab ts=4 sw=4
set ignorecase incsearch
set nu rnu
set linebreak
set noswapfile
set scrolloff=5 mouse=a
set wildmenu wildoptions=pum

call plug#begin()
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-commentary'
    Plug 'lervag/vimtex'
call plug#end()

let g:vimtex_view_automatic = 0

set termguicolors
colorscheme habamax

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <tab> :bn <CR>
nnoremap <s-tab> :bp <CR>
nnoremap <C-n> :set nonu! nornu! <CR>
nnoremap <C-tab> :setlocal formatoptions+=a <CR>
autocmd InsertEnter,WinLeave * if &number | set nornu | endif
autocmd InsertLeave,WinEnter * if &number | set rnu | endif
