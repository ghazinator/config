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

let g:vimtex_view_automatic = 0

set termguicolors
colorscheme habamax

call plug#begin()
    Plug 'mbbill/undotree'
call plug#end()

nnoremap <leader>u :UndotreeToggle<CR>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <tab> :bn <CR>
nnoremap <s-tab> :bp <CR>
nnoremap <C-n> :set nonu! nornu! <CR>
nnoremap <C-tab> :setlocal formatoptions+=a <CR>
autocmd InsertEnter,WinLeave * if &number | set nornu | endif
autocmd InsertLeave,WinEnter * if &number | set rnu | endif

if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
