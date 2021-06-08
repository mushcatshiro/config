set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'Valloric/YouCompleteMe'
Plugin 'preservim/nerdtree'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
map <C-n> :NERDTreeToggle<CR>

set number
set ruler
set encoding=utf-8
set background=dark
colorscheme palenight

set fileformat=unix
let python_highlight_all=1
syntax on

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
let $PATH.=':' . '/home/shiro/.vim/bundle/syntastic/'

autocmd Filetype python call SetPythonOptions()

function SetPythonOptions()
    set relativenumber
    set smartindent
    set tabstop=4
    set shiftwidth=4
    set textwidth=79
    set colorcolumn=79
    set softtabstop=4
    set expandtab
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 1
endfunction

autocmd VimEnter * NERDTree
let NERDTreeShowHidden=1
